import 'package:moor/moor.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

// Bases
class Employees extends Table {
  TextColumn get employeeID => text()();
  TextColumn get name => text().withLength(max: 32).nullable()();
  IntColumn get phoneNo => integer().nullable()();
  TextColumn get deviceID => text().nullable()();

  @override
  Set<Column> get primaryKey => {employeeID};
}

class Attendances extends Table {
  TextColumn get employeeID => text()();
  IntColumn get attendanceCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastAttendance => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {employeeID};
}

class Events extends Table {
  DateTimeColumn get eventTime => dateTime()();
  // Event types: attendance, contact, join, register
  TextColumn get eventType =>
      text().withDefault(const Constant('attendance'))();
  TextColumn get employeeIDA => text()();
  TextColumn get employeeIDB => text().nullable()();

  @override
  Set<Column> get primaryKey => {eventTime};
}

// Relational
class EmployeesWithAttendance {
  final Employee employee;
  final Attendance attendance;

  EmployeesWithAttendance(this.employee, this.attendance);
}

class EventWithEmployees {
  final Employee employeeA, employeeB;
  final Event event;

  EventWithEmployees(this.event, this.employeeA, this.employeeB);
}
