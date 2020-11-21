import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:moor2csv/moor2csv.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/Server/server.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

class DataBloc extends Cubit<ChangeStack> {
  final Database db;
  SafeSyncServer server;

  DataBloc(this.db) : super(db.cs) {
    server = SafeSyncServer(_handleParsedClientRequest);
  }

  //------------------- SERVER DATA HANDLING -------------------//
  void _handleParsedClientRequest(Map parsedRequest) {
    // As IoT device waits 15 seconds before making request, we make it up.
    DateTime _current = DateTime.now();
    _current.subtract(Duration(seconds: 10));

    // Don't need to register contact with Sanitizing station
    if (parsedRequest['contactDeviceID'] == 'safesync-iot-sanitize') return;
    if (parsedRequest['selfID'] == 'safesync-iot-sanitize') {
      giveAttendance(parsedRequest['contactDeviceID']);
      createEvent(Event(
          key: _current.toString() + parsedRequest['contactDeviceID'],
          deviceIDA: parsedRequest['contactDeviceID'],
          eventType: 'attendance',
          eventTime: _current));
    } else {
      createEvent(Event(
          key: _current.toString() + parsedRequest['selfID'],
          deviceIDA: parsedRequest['selfID'],
          deviceIDB: parsedRequest['contactDeviceID'],
          eventType: parsedRequest['type'],
          eventTime: _current));
    }
  }

  //------------------- DATABASE -------------------//
  // EMPLOYEES ACTIONS
  void resetSanitizingStation() async {
    Employee stationInDatabase =
        await db.getEmployeebyID('safesync-iot-sanitize', type: 'device');
    if (stationInDatabase != null) return; // Do nothing if already exists

    Employee _station = Employee(
      employeeID: 'safesync-iot-sanitize',
      name: 'Sanitizing Station (unmodifiable)',
      deviceID: 'safesync-iot-sanitize',
      phoneNo: 0,
    );
    await db.createEmployee(_station);
    // Too avoid bugs in Statistics
    await db.removeAttendanceSQL(
        Attendance(employeeID: 'safesync-iot-sanitize', attendanceCount: null));
  }

  void createEmployee(Employee employee) async {
    // SANITIZING STATION WILL ALWAYS EXIST
    resetSanitizingStation();
    await db.createEmployee(employee);
    emit(db.cs);
  }

  Future<List<Employee>> getAllEmployees(
      {String orderBy = 'name', String mode = 'asce'}) {
    return db.getAllEmployees(orderBy: orderBy, mode: mode);
  }

  Stream<List<Employee>> showAllEmployees(
      {String orderBy = 'name', String mode = 'asce'}) {
    return db.watchAllEmployees(orderBy: orderBy, mode: mode);
  }

  Future<Employee> getEmployeeByID(String id) {
    return db.getEmployeebyID(id);
  }

  void updateEmployee(Employee employee) async {
    await db.updateEmployee(employee);
    // SANITIZING STATION WILL ALWAYS EXIST
    resetSanitizingStation();
    emit(db.cs);
  }

  void deleteEmployee(Employee employee) async {
    db.deleteEmployee(employee);
    emit(db.cs);
  }

  // EVENTS ACTIONS. Event types: attendance, contact, danger, register
  void createEvent(Event event) async {
    await db.createEvent(event);
    emit(db.cs);
  }

  Stream<List<Event>> showAllEvents() {
    return db.watchAllEvents();
  }

  Stream<List<Event>> showEventsForCriteria(String criteria,
      {String type = 'deviceID'}) {
    return db.watchEventsForCriteria(criteria, type: type);
  }

  void updateEvent(Event event) async {
    db.updateEvent(event);
    emit(db.cs);
  }

  void deleteEvent(Event event) async {
    db.deleteEvent(event);
    emit(db.cs);
  }

  void clearEvents() async {
    db.clearEvents();
    emit(db.cs);
  }

  // Employee-Attendance Actions
  void giveAttendance(String deviceID) async {
    Employee _employee = await db.getEmployeebyID(deviceID, type: 'device');
    db.giveAttendance(_employee.employeeID);
    emit(db.cs);
  }

  void resetAttendance(String employeeID) {
    db.resetAttendance(employeeID);
    emit(db.cs);
  }

  void resetAllAttendances() async {
    List<Employee> _employees = await db.getAllEmployees();
    _employees.forEach((element) {
      if (element.deviceID != 'safesync-iot-sanitize')
        resetAttendance(element.employeeID);
    });
  }

  Stream<List<EmployeesWithAttendance>> getEmployeesWithAttendance(int bound,
      {String boundType = 'lower'}) {
    return db.watchEmployeeAttendanceComparitive(bound, boundType: boundType);
  }

  // Event-Employee Actions

  /// Returns A Map of two employees 'A' : EmployeeA and 'B' : Employee B
  /// associated with the event [_event].
  Future<Map<String, Employee>> getEmployeesFromEvent(Event _event) {
    return db.getEmployeesFromEvent(_event);
  }

  //Database manipulation actions
  Future<bool> exportDatabase(
      {bool getEmployees = false,
      bool getAttendances = false,
      bool getEvents = false}) async {
    MoorSQLToCSV _csvGenerator;
    bool didSucceed = true;
    if (getEmployees) {
      List<Employee> _employees = await db.getAllEmployees(orderBy: 'id');
      if (_employees.isNotEmpty) {
        _csvGenerator = MoorSQLToCSV(_employees, csvFileName: 'employees');
        didSucceed = didSucceed && await _csvGenerator.wasCreated;
      }
    }
    if (getAttendances) {
      List<Attendance> _attendances = await db.getAllAttendances();
      String _date = DateTime.now().toString();
      if (_attendances.isNotEmpty) {
        _csvGenerator = MoorSQLToCSV(_attendances,
            csvFileName: 'attendances_${_date.substring(0, 10)}');
        didSucceed = didSucceed && await _csvGenerator.wasCreated;
      }
    }
    if (getEvents) {
      List<Event> _events = await db.getAllEvents();
      if (_events.isNotEmpty) {
        _csvGenerator = MoorSQLToCSV(_events, csvFileName: 'events');
        didSucceed = didSucceed && await _csvGenerator.wasCreated;
      }
    }
    return didSucceed;
  }

  // Specific Statistics based actions
  Future<String> getSanitizeeNamesBy(
      {String orderBy = 'last', String mode = 'desc', int number = 1}) async {
    List<Attendance> _attendances =
        await db.getAllAttendances(orderBy: orderBy, mode: mode);

    if (_attendances.isEmpty ||
        (mode == 'desc' && _attendances[0].lastAttendance == null))
      return 'Nobody has sanitized yet!';

    // Handle Multiple results, with admittedly Spaghetti Code.
    String _names = '';
    int thisMany = number = min(number, _attendances.length);

    // If employees that haven't sanitized exist in ascending order
    if (mode == 'asce' && _attendances[0].lastAttendance == null) {
      for (int i = 0;
          i < _attendances.length && _attendances[i].lastAttendance == null;
          ++i) {
        Employee _employee =
            await db.getEmployeebyID(_attendances[i].employeeID);
        if (_employee == null) continue;
        _names += '${_employee.name}, ';
      }
      // Fix end Formatting.
      _names = _names.replaceRange(_names.length - 2, _names.length, '');
      return '$_names. Not sanitized yet!';
    }

    DateTime _last = _attendances[thisMany - 1].lastAttendance;
    // Handle query Case (on or desc : before/asce : after)
    for (int i = 0; i < _attendances.length; ++i) {
      if (i >= thisMany &&
          (_attendances[i].lastAttendance == null ||
              !_attendances[i].lastAttendance.isAtSameMomentAs(_last))) break;
      Employee _employee = await db.getEmployeebyID(_attendances[i].employeeID);

      if (_employee == null) continue;
      _names += '${_employee.name}, ';
    }

    // Fix end Formatting.
    _names = _names = _names.replaceRange(_names.length - 1, _names.length, '');
    if (_last == null) return '${_names}not sanitized yet!';
    String _lastAsString = _last.toString();
    return '$_names last on ${_lastAsString.substring(0, _lastAsString.length - 4)}.';
  }

  Future<int> getEventCount(
      {bool considerContacts = false,
      bool considerDangers = false,
      bool considerRegisters = false,
      bool considerAttendances = false}) async {
    int _numberOfEvents = 0;
    if (considerContacts) {
      List<Event> _contactEvents = await db.getEventsOfType(type: 'contact');
      _numberOfEvents += _contactEvents.length;
    }
    if (considerDangers) {
      List<Event> _dangerEvents = await db.getEventsOfType(type: 'danger');
      _numberOfEvents += _dangerEvents.length;
    }
    if (considerRegisters) {
      List<Event> _registerEvents = await db.getEventsOfType(type: 'register');
      _numberOfEvents += _registerEvents.length;
    }
    if (considerAttendances) {
      List<Event> _attendanceEvents =
          await db.getEventsOfType(type: 'attendance');
      _numberOfEvents += _attendanceEvents.length;
    }
    return _numberOfEvents;
  }

  // Out of all contacts, what percent is dangerous.
  Future<String> getDangerousContactsPercentage() async {
    int _contacts = await getEventCount(considerContacts: true);
    int _dangers = await getEventCount(considerDangers: true);
    // Divide by zero handling
    if (_contacts == 0 && _dangers == 0)
      return '0 %  ($_contacts Contacts, $_dangers Dangerous)';
    double percentageDanger = (_dangers * 100.0) / (_contacts + _dangers);
    return '${percentageDanger.toStringAsPrecision(2)} %  ($_contacts Contacts, $_dangers Dangerous)';
  }

  // MISCELLANEOUS
  bool get canUndo => db.cs.canUndo;
  void undo() async {
    db.cs.undo();
    emit(db.cs);
  }

  bool get canRedo => db.cs.canRedo;
  void redo() async {
    db.cs.redo();
    emit(db.cs);
  }

  void clear() async {
    db.deleteTables();
    db.cs.clearHistory();
    emit(db.cs);
  }

  void dispose() {
    db.close();
    emit(db.cs);
  }
}
