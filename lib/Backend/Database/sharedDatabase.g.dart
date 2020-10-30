// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharedDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final String employeeID;
  final String name;
  final int phoneNo;
  Employee(
      {@required this.id,
      @required this.employeeID,
      @required this.name,
      @required this.phoneNo});
  factory Employee.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Employee(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      employeeID: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_i_d']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      phoneNo:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}phone_no']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || employeeID != null) {
      map['employee_i_d'] = Variable<String>(employeeID);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phoneNo != null) {
      map['phone_no'] = Variable<int>(phoneNo);
    }
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      employeeID: employeeID == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeID),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phoneNo: phoneNo == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNo),
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      employeeID: serializer.fromJson<String>(json['employeeID']),
      name: serializer.fromJson<String>(json['name']),
      phoneNo: serializer.fromJson<int>(json['phoneNo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeID': serializer.toJson<String>(employeeID),
      'name': serializer.toJson<String>(name),
      'phoneNo': serializer.toJson<int>(phoneNo),
    };
  }

  Employee copyWith({int id, String employeeID, String name, int phoneNo}) =>
      Employee(
        id: id ?? this.id,
        employeeID: employeeID ?? this.employeeID,
        name: name ?? this.name,
        phoneNo: phoneNo ?? this.phoneNo,
      );
  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('employeeID: $employeeID, ')
          ..write('name: $name, ')
          ..write('phoneNo: $phoneNo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(employeeID.hashCode, $mrjc(name.hashCode, phoneNo.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.employeeID == this.employeeID &&
          other.name == this.name &&
          other.phoneNo == this.phoneNo);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<String> employeeID;
  final Value<String> name;
  final Value<int> phoneNo;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.employeeID = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNo = const Value.absent(),
  });
  EmployeesCompanion.insert({
    @required int id,
    @required String employeeID,
    @required String name,
    @required int phoneNo,
  })  : id = Value(id),
        employeeID = Value(employeeID),
        name = Value(name),
        phoneNo = Value(phoneNo);
  static Insertable<Employee> custom({
    Expression<int> id,
    Expression<String> employeeID,
    Expression<String> name,
    Expression<int> phoneNo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeID != null) 'employee_i_d': employeeID,
      if (name != null) 'name': name,
      if (phoneNo != null) 'phone_no': phoneNo,
    });
  }

  EmployeesCompanion copyWith(
      {Value<int> id,
      Value<String> employeeID,
      Value<String> name,
      Value<int> phoneNo}) {
    return EmployeesCompanion(
      id: id ?? this.id,
      employeeID: employeeID ?? this.employeeID,
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeID.present) {
      map['employee_i_d'] = Variable<String>(employeeID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNo.present) {
      map['phone_no'] = Variable<int>(phoneNo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('employeeID: $employeeID, ')
          ..write('name: $name, ')
          ..write('phoneNo: $phoneNo')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  final GeneratedDatabase _db;
  final String _alias;
  $EmployeesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _employeeIDMeta = const VerificationMeta('employeeID');
  GeneratedTextColumn _employeeID;
  @override
  GeneratedTextColumn get employeeID => _employeeID ??= _constructEmployeeID();
  GeneratedTextColumn _constructEmployeeID() {
    return GeneratedTextColumn(
      'employee_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false, maxTextLength: 32);
  }

  final VerificationMeta _phoneNoMeta = const VerificationMeta('phoneNo');
  GeneratedIntColumn _phoneNo;
  @override
  GeneratedIntColumn get phoneNo => _phoneNo ??= _constructPhoneNo();
  GeneratedIntColumn _constructPhoneNo() {
    return GeneratedIntColumn(
      'phone_no',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, employeeID, name, phoneNo];
  @override
  $EmployeesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'employees';
  @override
  final String actualTableName = 'employees';
  @override
  VerificationContext validateIntegrity(Insertable<Employee> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('employee_i_d')) {
      context.handle(
          _employeeIDMeta,
          employeeID.isAcceptableOrUnknown(
              data['employee_i_d'], _employeeIDMeta));
    } else if (isInserting) {
      context.missing(_employeeIDMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone_no')) {
      context.handle(_phoneNoMeta,
          phoneNo.isAcceptableOrUnknown(data['phone_no'], _phoneNoMeta));
    } else if (isInserting) {
      context.missing(_phoneNoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, employeeID};
  @override
  Employee map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Employee.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(_db, alias);
  }
}

class Attendance extends DataClass implements Insertable<Attendance> {
  final String employeeID;
  final int attendanceCount;
  final DateTime lastAttendance;
  Attendance(
      {@required this.employeeID,
      @required this.attendanceCount,
      this.lastAttendance});
  factory Attendance.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Attendance(
      employeeID: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_i_d']),
      attendanceCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}attendance_count']),
      lastAttendance: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_attendance']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || employeeID != null) {
      map['employee_i_d'] = Variable<String>(employeeID);
    }
    if (!nullToAbsent || attendanceCount != null) {
      map['attendance_count'] = Variable<int>(attendanceCount);
    }
    if (!nullToAbsent || lastAttendance != null) {
      map['last_attendance'] = Variable<DateTime>(lastAttendance);
    }
    return map;
  }

  AttendancesCompanion toCompanion(bool nullToAbsent) {
    return AttendancesCompanion(
      employeeID: employeeID == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeID),
      attendanceCount: attendanceCount == null && nullToAbsent
          ? const Value.absent()
          : Value(attendanceCount),
      lastAttendance: lastAttendance == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttendance),
    );
  }

  factory Attendance.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Attendance(
      employeeID: serializer.fromJson<String>(json['employeeID']),
      attendanceCount: serializer.fromJson<int>(json['attendanceCount']),
      lastAttendance: serializer.fromJson<DateTime>(json['lastAttendance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeID': serializer.toJson<String>(employeeID),
      'attendanceCount': serializer.toJson<int>(attendanceCount),
      'lastAttendance': serializer.toJson<DateTime>(lastAttendance),
    };
  }

  Attendance copyWith(
          {String employeeID, int attendanceCount, DateTime lastAttendance}) =>
      Attendance(
        employeeID: employeeID ?? this.employeeID,
        attendanceCount: attendanceCount ?? this.attendanceCount,
        lastAttendance: lastAttendance ?? this.lastAttendance,
      );
  @override
  String toString() {
    return (StringBuffer('Attendance(')
          ..write('employeeID: $employeeID, ')
          ..write('attendanceCount: $attendanceCount, ')
          ..write('lastAttendance: $lastAttendance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(employeeID.hashCode,
      $mrjc(attendanceCount.hashCode, lastAttendance.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Attendance &&
          other.employeeID == this.employeeID &&
          other.attendanceCount == this.attendanceCount &&
          other.lastAttendance == this.lastAttendance);
}

class AttendancesCompanion extends UpdateCompanion<Attendance> {
  final Value<String> employeeID;
  final Value<int> attendanceCount;
  final Value<DateTime> lastAttendance;
  const AttendancesCompanion({
    this.employeeID = const Value.absent(),
    this.attendanceCount = const Value.absent(),
    this.lastAttendance = const Value.absent(),
  });
  AttendancesCompanion.insert({
    @required String employeeID,
    @required int attendanceCount,
    this.lastAttendance = const Value.absent(),
  })  : employeeID = Value(employeeID),
        attendanceCount = Value(attendanceCount);
  static Insertable<Attendance> custom({
    Expression<String> employeeID,
    Expression<int> attendanceCount,
    Expression<DateTime> lastAttendance,
  }) {
    return RawValuesInsertable({
      if (employeeID != null) 'employee_i_d': employeeID,
      if (attendanceCount != null) 'attendance_count': attendanceCount,
      if (lastAttendance != null) 'last_attendance': lastAttendance,
    });
  }

  AttendancesCompanion copyWith(
      {Value<String> employeeID,
      Value<int> attendanceCount,
      Value<DateTime> lastAttendance}) {
    return AttendancesCompanion(
      employeeID: employeeID ?? this.employeeID,
      attendanceCount: attendanceCount ?? this.attendanceCount,
      lastAttendance: lastAttendance ?? this.lastAttendance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeID.present) {
      map['employee_i_d'] = Variable<String>(employeeID.value);
    }
    if (attendanceCount.present) {
      map['attendance_count'] = Variable<int>(attendanceCount.value);
    }
    if (lastAttendance.present) {
      map['last_attendance'] = Variable<DateTime>(lastAttendance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendancesCompanion(')
          ..write('employeeID: $employeeID, ')
          ..write('attendanceCount: $attendanceCount, ')
          ..write('lastAttendance: $lastAttendance')
          ..write(')'))
        .toString();
  }
}

class $AttendancesTable extends Attendances
    with TableInfo<$AttendancesTable, Attendance> {
  final GeneratedDatabase _db;
  final String _alias;
  $AttendancesTable(this._db, [this._alias]);
  final VerificationMeta _employeeIDMeta = const VerificationMeta('employeeID');
  GeneratedTextColumn _employeeID;
  @override
  GeneratedTextColumn get employeeID => _employeeID ??= _constructEmployeeID();
  GeneratedTextColumn _constructEmployeeID() {
    return GeneratedTextColumn(
      'employee_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _attendanceCountMeta =
      const VerificationMeta('attendanceCount');
  GeneratedIntColumn _attendanceCount;
  @override
  GeneratedIntColumn get attendanceCount =>
      _attendanceCount ??= _constructAttendanceCount();
  GeneratedIntColumn _constructAttendanceCount() {
    return GeneratedIntColumn(
      'attendance_count',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastAttendanceMeta =
      const VerificationMeta('lastAttendance');
  GeneratedDateTimeColumn _lastAttendance;
  @override
  GeneratedDateTimeColumn get lastAttendance =>
      _lastAttendance ??= _constructLastAttendance();
  GeneratedDateTimeColumn _constructLastAttendance() {
    return GeneratedDateTimeColumn(
      'last_attendance',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [employeeID, attendanceCount, lastAttendance];
  @override
  $AttendancesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'attendances';
  @override
  final String actualTableName = 'attendances';
  @override
  VerificationContext validateIntegrity(Insertable<Attendance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_i_d')) {
      context.handle(
          _employeeIDMeta,
          employeeID.isAcceptableOrUnknown(
              data['employee_i_d'], _employeeIDMeta));
    } else if (isInserting) {
      context.missing(_employeeIDMeta);
    }
    if (data.containsKey('attendance_count')) {
      context.handle(
          _attendanceCountMeta,
          attendanceCount.isAcceptableOrUnknown(
              data['attendance_count'], _attendanceCountMeta));
    } else if (isInserting) {
      context.missing(_attendanceCountMeta);
    }
    if (data.containsKey('last_attendance')) {
      context.handle(
          _lastAttendanceMeta,
          lastAttendance.isAcceptableOrUnknown(
              data['last_attendance'], _lastAttendanceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeID};
  @override
  Attendance map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Attendance.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AttendancesTable createAlias(String alias) {
    return $AttendancesTable(_db, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final DateTime eventTime;
  final String employeeIDA;
  final String employeeIDB;
  Event(
      {@required this.eventTime,
      @required this.employeeIDA,
      @required this.employeeIDB});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Event(
      eventTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_time']),
      employeeIDA: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_i_d_a']),
      employeeIDB: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_i_d_b']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || eventTime != null) {
      map['event_time'] = Variable<DateTime>(eventTime);
    }
    if (!nullToAbsent || employeeIDA != null) {
      map['employee_i_d_a'] = Variable<String>(employeeIDA);
    }
    if (!nullToAbsent || employeeIDB != null) {
      map['employee_i_d_b'] = Variable<String>(employeeIDB);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      eventTime: eventTime == null && nullToAbsent
          ? const Value.absent()
          : Value(eventTime),
      employeeIDA: employeeIDA == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeIDA),
      employeeIDB: employeeIDB == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeIDB),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      eventTime: serializer.fromJson<DateTime>(json['eventTime']),
      employeeIDA: serializer.fromJson<String>(json['employeeIDA']),
      employeeIDB: serializer.fromJson<String>(json['employeeIDB']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventTime': serializer.toJson<DateTime>(eventTime),
      'employeeIDA': serializer.toJson<String>(employeeIDA),
      'employeeIDB': serializer.toJson<String>(employeeIDB),
    };
  }

  Event copyWith(
          {DateTime eventTime, String employeeIDA, String employeeIDB}) =>
      Event(
        eventTime: eventTime ?? this.eventTime,
        employeeIDA: employeeIDA ?? this.employeeIDA,
        employeeIDB: employeeIDB ?? this.employeeIDB,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('eventTime: $eventTime, ')
          ..write('employeeIDA: $employeeIDA, ')
          ..write('employeeIDB: $employeeIDB')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      eventTime.hashCode, $mrjc(employeeIDA.hashCode, employeeIDB.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.eventTime == this.eventTime &&
          other.employeeIDA == this.employeeIDA &&
          other.employeeIDB == this.employeeIDB);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<DateTime> eventTime;
  final Value<String> employeeIDA;
  final Value<String> employeeIDB;
  const EventsCompanion({
    this.eventTime = const Value.absent(),
    this.employeeIDA = const Value.absent(),
    this.employeeIDB = const Value.absent(),
  });
  EventsCompanion.insert({
    @required DateTime eventTime,
    @required String employeeIDA,
    @required String employeeIDB,
  })  : eventTime = Value(eventTime),
        employeeIDA = Value(employeeIDA),
        employeeIDB = Value(employeeIDB);
  static Insertable<Event> custom({
    Expression<DateTime> eventTime,
    Expression<String> employeeIDA,
    Expression<String> employeeIDB,
  }) {
    return RawValuesInsertable({
      if (eventTime != null) 'event_time': eventTime,
      if (employeeIDA != null) 'employee_i_d_a': employeeIDA,
      if (employeeIDB != null) 'employee_i_d_b': employeeIDB,
    });
  }

  EventsCompanion copyWith(
      {Value<DateTime> eventTime,
      Value<String> employeeIDA,
      Value<String> employeeIDB}) {
    return EventsCompanion(
      eventTime: eventTime ?? this.eventTime,
      employeeIDA: employeeIDA ?? this.employeeIDA,
      employeeIDB: employeeIDB ?? this.employeeIDB,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventTime.present) {
      map['event_time'] = Variable<DateTime>(eventTime.value);
    }
    if (employeeIDA.present) {
      map['employee_i_d_a'] = Variable<String>(employeeIDA.value);
    }
    if (employeeIDB.present) {
      map['employee_i_d_b'] = Variable<String>(employeeIDB.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('eventTime: $eventTime, ')
          ..write('employeeIDA: $employeeIDA, ')
          ..write('employeeIDB: $employeeIDB')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventsTable(this._db, [this._alias]);
  final VerificationMeta _eventTimeMeta = const VerificationMeta('eventTime');
  GeneratedDateTimeColumn _eventTime;
  @override
  GeneratedDateTimeColumn get eventTime => _eventTime ??= _constructEventTime();
  GeneratedDateTimeColumn _constructEventTime() {
    return GeneratedDateTimeColumn(
      'event_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _employeeIDAMeta =
      const VerificationMeta('employeeIDA');
  GeneratedTextColumn _employeeIDA;
  @override
  GeneratedTextColumn get employeeIDA =>
      _employeeIDA ??= _constructEmployeeIDA();
  GeneratedTextColumn _constructEmployeeIDA() {
    return GeneratedTextColumn(
      'employee_i_d_a',
      $tableName,
      false,
    );
  }

  final VerificationMeta _employeeIDBMeta =
      const VerificationMeta('employeeIDB');
  GeneratedTextColumn _employeeIDB;
  @override
  GeneratedTextColumn get employeeIDB =>
      _employeeIDB ??= _constructEmployeeIDB();
  GeneratedTextColumn _constructEmployeeIDB() {
    return GeneratedTextColumn(
      'employee_i_d_b',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [eventTime, employeeIDA, employeeIDB];
  @override
  $EventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_time')) {
      context.handle(_eventTimeMeta,
          eventTime.isAcceptableOrUnknown(data['event_time'], _eventTimeMeta));
    } else if (isInserting) {
      context.missing(_eventTimeMeta);
    }
    if (data.containsKey('employee_i_d_a')) {
      context.handle(
          _employeeIDAMeta,
          employeeIDA.isAcceptableOrUnknown(
              data['employee_i_d_a'], _employeeIDAMeta));
    } else if (isInserting) {
      context.missing(_employeeIDAMeta);
    }
    if (data.containsKey('employee_i_d_b')) {
      context.handle(
          _employeeIDBMeta,
          employeeIDB.isAcceptableOrUnknown(
              data['employee_i_d_b'], _employeeIDBMeta));
    } else if (isInserting) {
      context.missing(_employeeIDBMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventTime};
  @override
  Event map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Event.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
  }
}

abstract class _$SharedDatabase extends GeneratedDatabase {
  _$SharedDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EmployeesTable _employees;
  $EmployeesTable get employees => _employees ??= $EmployeesTable(this);
  $AttendancesTable _attendances;
  $AttendancesTable get attendances => _attendances ??= $AttendancesTable(this);
  $EventsTable _events;
  $EventsTable get events => _events ??= $EventsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [employees, attendances, events];
}
