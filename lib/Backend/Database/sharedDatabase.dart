import 'package:moor/moor.dart';

import 'dataClasses.dart';
part 'sharedDatabase.g.dart';

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

  // Relational
  Stream<List<Employee>> watchAttendaceEmployeeGreater(int lowerBound) =>
      (select(employees)
            ..join(<Join<Table, DataClass>>[
              innerJoin(
                attendances,
                employees.employeeID.equalsExp(attendances.employeeID) &
                    attendances.attendanceCount
                        .isBiggerOrEqual(Constant(lowerBound)),
              ),
            ]))
          .watch();

  Stream<List<Employee>> watchAttendaceEmployeeLesser(int upperBound) =>
      (select(employees)
            ..join(<Join<Table, DataClass>>[
              innerJoin(
                attendances,
                employees.employeeID.equalsExp(attendances.employeeID) &
                    attendances.attendanceCount
                        .isSmallerOrEqual(Constant(upperBound)),
              ),
            ]))
          .watch();
}
