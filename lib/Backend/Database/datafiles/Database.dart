import 'package:moor/moor.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';
import 'package:safe_sync/Backend/Database/datafiles/dbUtils.dart';

part 'Database.g.dart';

@UseMoor(tables: [Employees, Attendances, Events])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);
  final cs = ChangeStack();

  @override
  int get schemaVersion => 1;

  // DATABASE OPERATIONS
  //EMPLOYEES
  Future<List<Employee>> getAllEmployees(
          {String orderBy = 'asce', String mode = 'name'}) =>
      (select(employees)
            ..orderBy([
              (u) {
                GeneratedTextColumn criteria = employees.employeeID;
                OrderingMode order =
                    (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                if (orderBy == 'id') criteria = employees.employeeID;
                if (orderBy == 'name') criteria = employees.name;
                if (orderBy == 'device') criteria = employees.deviceID;
                return OrderingTerm(expression: criteria, mode: order);
              }
            ]))
          .get();

  Future<Employee> getEmployeebyID(String id, {String type = 'employee'}) {
    final query = select(employees);
    query.where((employees) {
      if (type.compareTo('device') == 0) return employees.deviceID.equals(id);
      return employees.employeeID.equals(id);
    });
    return query.getSingle();
  }

  Stream<List<Employee>> watchAllEmployees(
          {String orderBy = 'name', String mode = 'asce'}) =>
      (select(employees)
            ..orderBy([
              (u) {
                GeneratedTextColumn criteria = employees.employeeID;
                OrderingMode order =
                    (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                if (orderBy == 'id') criteria = employees.employeeID;
                if (orderBy == 'name') criteria = employees.name;
                if (orderBy == 'device') criteria = employees.deviceID;
                return OrderingTerm(expression: criteria, mode: order);
              }
            ]))
          .watch();
  Future<int> createEmployeeSQL(Employee employee) =>
      into(employees).insert(employee);
  Future updateEmployeeSQL(Employee employee) =>
      update(employees).replace(employee);
  Future removeEmployeeSQL(Employee employee) =>
      delete(employees).delete(employee);

  //Attendances
  Future<List<Attendance>> getAllAttendances(
          {String orderBy = 'last', String mode = 'asce'}) =>
      (select(attendances)
            ..orderBy([
              (u) {
                dynamic criteria = employees.employeeID;
                OrderingMode order =
                    (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                if (orderBy == 'id') criteria = attendances.employeeID;
                if (orderBy == 'number') criteria = attendances.attendanceCount;
                if (orderBy == 'last') criteria = attendances.lastAttendance;
                return OrderingTerm(expression: criteria, mode: order);
              }
            ]))
          .get();
  Stream<List<Attendance>> watchAllAttendances(
          {String orderBy = 'last', String mode = 'asce'}) =>
      (select(attendances)
            ..orderBy([
              (u) {
                dynamic criteria = employees.employeeID;
                OrderingMode order =
                    (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                if (orderBy == 'id') criteria = attendances.employeeID;
                if (orderBy == 'number') criteria = attendances.attendanceCount;
                if (orderBy == 'last') criteria = attendances.lastAttendance;
                return OrderingTerm(expression: criteria, mode: order);
              }
            ]))
          .watch();
  Future<int> createAttendanceSQL(Attendance attendance) =>
      into(attendances).insert(attendance);
  Future updateAttendanceSQL(Attendance attendance) =>
      update(attendances).replace(attendance);
  Future removeAttendanceSQL(Attendance attendance) =>
      delete(attendances).delete(attendance);

  // Events
  Future<List<Event>> getAllEvents(
          {String orderBy = 'time', String mode = 'desc'}) =>
      (select(events)
            ..orderBy([
              (u) {
                dynamic criteria = employees.employeeID;
                OrderingMode order =
                    (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                if (orderBy == 'idA') criteria = events.deviceIDA;
                if (orderBy == 'idB') criteria = events.deviceIDB;
                if (orderBy == 'time') criteria = events.eventTime;
                return OrderingTerm(expression: criteria, mode: order);
              }
            ]))
          .get();
  Stream<List<Event>> watchAllEvents(
          {String orderBy = 'time', String mode = 'desc'}) =>
      (select(events)
            ..orderBy([
              (u) {
                dynamic criteria = employees.employeeID;
                OrderingMode order =
                    (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                if (orderBy == 'idA') criteria = events.deviceIDA;
                if (orderBy == 'idB') criteria = events.deviceIDB;
                if (orderBy == 'time') criteria = events.eventTime;
                return OrderingTerm(expression: criteria, mode: order);
              }
            ]))
          .watch();
  Stream<List<Event>> watchEventsForCriteria(String criteria,
      {String type = 'deviceID'}) {
    var query = select(events);
    if (type == 'deviceID')
      query.where((events) => events.deviceIDA.equals(criteria));
    else if (type == 'eventType') {
      if (criteria == 'contactDanger')
        query.where((events) =>
            events.eventType.equals('contact') |
            events.eventType.equals('danger'));
      else
        query.where((events) => events.eventType.equals(criteria));
    }
    query.orderBy([(u) => OrderingTerm.desc(events.eventTime)]);
    return query.watch();
  }

  Future<List<Event>> getEventsOfType({String type = 'contact'}) =>
      (select(events)..where((events) => events.eventType.equals(type))).get();

  Future<int> createEventSQL(Event event) => into(events).insert(event);
  Future updateEventSQL(Event event) => update(events).replace(event);
  Future removeEventSQL(Event event) => delete(events).delete(event);

  // Relational Attendance-Employee Actions
  Stream<List<EmployeesWithAttendance>> watchEmployeeAttendanceComparitive(
      int bound,
      {String boundType = 'upper'}) {
    final query = select(employees).join([
      leftOuterJoin(
          attendances, employees.employeeID.equalsExp(attendances.employeeID))
    ]);

    if (boundType == 'lower')
      query.where(
        attendances.attendanceCount.isBiggerOrEqual(Constant(bound)),
      );
    else
      query.where(
        attendances.attendanceCount.isSmallerOrEqual(Constant(bound)),
      );

    return query.watch().map((rows) {
      return rows.map((row) {
        return EmployeesWithAttendance(
          row.readTable(employees),
          row.readTable(attendances),
        );
      }).toList();
    });
  }

  // Relational Event-Employee Actions
  Future<EventWithEmployees> getEmployeeFromEvent(Event _event) async {
    Employee _a = await getEmployeebyID(_event.deviceIDA, type: 'device'),
        _b = await getEmployeebyID(_event.deviceIDB, type: 'device');
    return EventWithEmployees(_event, _a, _b);
  }

  // Dart Employee Handling
  Future createEmployee(Employee employee) async {
    return insertRow(cs, employees, employee);
  }

  Future updateEmployee(Employee employee) async {
    return updateRow(cs, employees, employee);
  }

  Future deleteEmployee(Employee employee) {
    return deleteRow(cs, employees, employee);
  }

  // Dart Attendance Handling
  Future resetAttendance(String employeeID) async {
    Attendance _attendance =
        Attendance(employeeID: employeeID, attendanceCount: 0);

    // If already exists, remove first
    deleteRow(cs, attendances, _attendance);
    return insertRow(cs, attendances, _attendance);
  }

  Future giveAttendance(String employeeID) async {
    final query = select(attendances);
    query.where((attendences) => attendances.employeeID.equals(employeeID));
    Attendance _attendance = await query.getSingle();

    // HANDLE EMPLOYEE NOT FOUND
    if (_attendance == null) return;

    Attendance _newAttendance = Attendance(
        employeeID: employeeID,
        attendanceCount: _attendance.attendanceCount + 1,
        lastAttendance: DateTime.now());
    return updateRow(cs, attendances, _newAttendance);
  }

  // Dart Event handling
  Future createEvent(Event _event) async {
    return insertRow(
      cs,
      events,
      _event,
    );
  }

  Future updateEvent(Event event) async {
    return updateRow(cs, events, event);
  }

  Future deleteEvent(Event event) async {
    return deleteRow(cs, events, event);
  }

  Future clearEvents() async {
    return delete(events).go();
  }

  // OVERALL DATABASE ACTIONS
  Future<Map<String, List<DataClass>>> getAllTables() async {
    List<Employee> _employees = await getAllEmployees();
    List<Attendance> _attendances = await getAllAttendances();
    List<Event> _events = await getAllEvents();
    return {
      'employees': _employees,
      'attendances': _attendances,
      'events': _events
    };
  }

  Future deleteTables() async {
    delete(employees).go();
    delete(attendances).go();
    delete(events).go();
  }
}
