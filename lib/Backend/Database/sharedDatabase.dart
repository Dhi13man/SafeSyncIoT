import 'package:moor_flutter/moor_flutter.dart';

part 'sharedDatabase.g.dart';

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
  TextColumn get employeeIDA => text()();
  TextColumn get employeeIDB => text()();

  @override
  Set<Column> get primaryKey => {eventTime};
}

@UseMoor(tables: [Employees, Attendances, Events])
class SharedDatabase extends _$SharedDatabase {
  SharedDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  // DATABASE OPERATIONS
  //EMPLOYEES
  Future<List<Employee>> getAllEmployees() => select(employees).get();
  Stream<List<Employee>> watchAllEmployees() => select(employees).watch();
  Future<int> insertEmployee(Employee employee) =>
      into(employees).insert(employee);
  Future updateEmployee(Employee employee) =>
      update(employees).replace(employee);
  Future removeEmployee(Employee employee) =>
      delete(employees).delete(employee);

  //Attendances
  Future<List<Attendance>> getAllAttendances() => select(attendances).get();
  Stream<List<Attendance>> watchAllAttendances() => select(attendances).watch();
  Future<int> insertAttendance(Attendance attendance) =>
      into(attendances).insert(attendance);
  Future updateAttendance(Attendance attendance) =>
      update(attendances).replace(attendance);
  Future removeAttendance(Attendance attendance) =>
      delete(attendances).delete(attendance);

  // Events
  Future<List<Event>> getAllEvents() => select(events).get();
  Stream<List<Event>> watchAllEvents() => select(events).watch();
  Future<int> insertEvent(Event event) => into(events).insert(event);
  Future updateEvent(Event event) => update(events).replace(event);
  Future removeEvent(Event event) => delete(events).delete(event);
}
