import 'package:bloc/bloc.dart';
import 'package:safe_sync/Backend/moorSQL2CSV.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/Server/server.dart';

class DataBloc extends Cubit<ChangeStack> {
  final Database db;
  SafeSyncServer server;

  DataBloc(this.db) : super(db.cs) {
    server = SafeSyncServer(handleParsedClientRequest);
  }

  //------------------- SERVER -------------------//
  void handleParsedClientRequest(Map parsedRequest) {
    // As IoT device waits 15 seconds before making request, we make it up.
    DateTime _current = DateTime.now();
    _current.subtract(Duration(seconds: 15));

    // Don't need to register contact with Sanitizing station
    if (parsedRequest['contactDeviceID'] == 'safesync-iot-sanitize') return;
    if (parsedRequest['selfID'] == 'safesync-iot-sanitize') {
      giveAttendance(parsedRequest['contactDeviceID']);
      createEvent(Event(
          key: _current.toString() + parsedRequest['selfID'],
          deviceIDA: parsedRequest['selfID'],
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
        phoneNo: 0);
    await db.createEmployee(_station);
  }

  void createEmployee(Employee employee) async {
    // SANITIZING STATION WILL ALWAYS EXIST
    resetSanitizingStation();
    await db.createEmployee(employee);
    emit(db.cs);
  }

  Stream<List<Employee>> showAllEmployees(
      {String orderBy = 'asce', String mode = 'name'}) {
    return db.watchAllEmployees(orderBy: orderBy, mode: mode);
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

  // EVENTS ACTIONS. Event types: attendance, contact, join, register
  void createEvent(Event event) async {
    await db.createEvent(event);
    emit(db.cs);
  }

  Stream<List<Event>> showAllEvents() {
    return db.watchAllEvents();
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
  void giveAttendance(String employeeID) {
    db.giveAttendance(employeeID);
    emit(db.cs);
  }

  void resetAttendance(String employeeID) {
    db.resetAttendance(employeeID);
    emit(db.cs);
  }

  Stream<List<EmployeesWithAttendance>> getEmployeesWithAttendance(int bound,
      {String boundType = 'lower'}) {
    if (boundType == 'lower') return db.watchEmployeeAttendanceGreater(bound);
    return db.watchEmployeeAttendanceLesser(bound);
  }

  // Event-Employee Actions
  Future<EventWithEmployees> getEmployeesFromEvent(Event _event) {
    return db.getEmployeeFromEvent(_event);
  }

  //Database manipulation actions
  Future<bool> exportDatabase(
      {bool getEmployees = true,
      bool getAttendances = true,
      bool getEvents = true}) async {
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
      if (_attendances.isNotEmpty) {
        _csvGenerator = MoorSQLToCSV(_attendances, csvFileName: 'attendances');
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

  bool get canUndo => db.cs.canUndo;
  void undo() async {
    await db.cs.undo();
    emit(db.cs);
  }

  bool get canRedo => db.cs.canRedo;
  void redo() async {
    await db.cs.redo();
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
