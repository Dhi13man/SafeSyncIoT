import 'package:moor/moor.dart';

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
