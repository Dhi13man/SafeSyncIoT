import 'package:moor/moor.dart';
import 'package:undo/undo.dart';

import 'dataClasses.dart';
import 'db_utils.dart';
part 'sharedDatabase.g.dart';

@UseMoor(tables: [Employees, Attendances, Events])
class SharedDatabase extends _$SharedDatabase {
  SharedDatabase(QueryExecutor e) : super(e);
  final cs = ChangeStack();

  @override
  int get schemaVersion => 1;

  // DATABASE OPERATIONS
  //EMPLOYEES
  Future<List<Employee>> getAllEmployees() => select(employees).get();
  Stream<List<Employee>> watchAllEmployees() => select(employees).watch();
  Future<int> createEmployeeSQL(Employee employee) =>
      into(employees).insert(employee);
  Future updateEmployeeSQL(Employee employee) =>
      update(employees).replace(employee);
  Future removeEmployeeSQL(Employee employee) =>
      delete(employees).delete(employee);

  //Attendances
  Future<List<Attendance>> getAllAttendances() => select(attendances).get();
  Stream<List<Attendance>> watchAllAttendances() => select(attendances).watch();
  Future<int> createAttendanceSQL(Attendance attendance) =>
      into(attendances).insert(attendance);
  Future updateAttendanceSQL(Attendance attendance) =>
      update(attendances).replace(attendance);
  Future removeAttendanceSQL(Attendance attendance) =>
      delete(attendances).delete(attendance);

  // Events
  Future<List<Event>> getAllEvents() => select(events).get();
  Stream<List<Event>> watchAllEvents() => select(events).watch();
  Future<int> createEventSQL(Event event) => into(events).insert(event);
  Future updateEventSQL(Event event) => update(events).replace(event);
  Future removeEventSQL(Event event) => delete(events).delete(event);

  // Relational Attendance-Employee Actions
  Stream<List<EmployeesWithAttendance>> watchEmployeeAttendaceGreater(
      int lowerBound) {
    final query = select(employees).join([
      leftOuterJoin(
          attendances, employees.employeeID.equalsExp(attendances.employeeID))
    ]);
    query.where(
      attendances.attendanceCount.isBiggerOrEqual(Constant(lowerBound)),
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

  Stream<List<EmployeesWithAttendance>> watchEmployeeAttendaceLesser(
      int lowerBound) {
    final query = select(employees).join([
      leftOuterJoin(
          attendances, employees.employeeID.equalsExp(attendances.employeeID))
    ]);
    query.where(
      attendances.attendanceCount.isSmallerOrEqual(Constant(lowerBound)),
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
    return updateRow(cs, attendances, _attendance);
  }

  Future giveAttendance(String employeeID) async {
    Attendance _attendance =
        Attendance(employeeID: employeeID, attendanceCount: null);
    _attendance = await (select(attendances)..whereSamePrimaryKey(_attendance))
        .getSingle();
    Attendance _newAttendance = Attendance(
        employeeID: employeeID,
        attendanceCount: _attendance.attendanceCount + 1);
    return updateRow(cs, attendances, _newAttendance);
  }

  // Dart Event handling
  Future<int> createEvent(Event event) {
    return insertRow(
      cs,
      events,
      event,
    );
  }

  Future updateEvent(Event event) async {
    return updateRow(cs, events, event);
  }

  Future deleteEvent(Event event) {
    return deleteRow(cs, events, event);
  }
}
