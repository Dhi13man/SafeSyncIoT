import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/Database/dataClasses.dart';
import 'package:safe_sync/Backend/Database/sharedDatabase.dart';

/// Class that keeps information about a category and whether it's selected at
/// the moment.
///
class DataBloc extends Cubit<ChangeStack> {
  DataBloc(this.db) : super(db.cs) {
    init();
  }

  final SharedDatabase db;
  final BehaviorSubject<Employee> _activeCategory =
      BehaviorSubject.seeded(null);

  void init() {}

  // EMPLOYEES ACTIONS
  void createEmployee(Employee employee) async {
    await db.createEmployee(employee);
    emit(db.cs);
    showEmployee(employee);
  }

  void showEmployee(Employee employee) {
    _activeCategory.add(employee);
  }

  Stream<List<Employee>> showAllEmployees() {
    return db.watchAllEmployees();
  }

  void updateEmployee(Employee employee) async {
    db.updateEmployee(employee);
    emit(db.cs);
  }

  void deleteEmployee(Employee employee) async {
    db.deleteEmployee(employee);
    emit(db.cs);
  }

  // EVENTS ACTIONS
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
    if (boundType == 'lower')
      return db.watchEmployeeAttendaceGreater(bound);
    else
      return db.watchEmployeeAttendaceLesser(bound);
  }

  // Database manipulation actions
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
