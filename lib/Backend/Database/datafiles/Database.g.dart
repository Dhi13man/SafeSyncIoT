// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Employee extends DataClass implements Insertable<Employee> {
  final String employeeID;
  final String name;
  final int phoneNo;
  final String deviceID;
  Employee({@required this.employeeID, this.name, this.phoneNo, this.deviceID});
  factory Employee.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Employee(
      employeeID: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_i_d']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      phoneNo:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}phone_no']),
      deviceID: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}device_i_d']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || employeeID != null) {
      map['employee_i_d'] = Variable<String>(employeeID);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phoneNo != null) {
      map['phone_no'] = Variable<int>(phoneNo);
    }
    if (!nullToAbsent || deviceID != null) {
      map['device_i_d'] = Variable<String>(deviceID);
    }
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      employeeID: employeeID == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeID),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phoneNo: phoneNo == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNo),
      deviceID: deviceID == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceID),
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Employee(
      employeeID: serializer.fromJson<String>(json['employeeID']),
      name: serializer.fromJson<String>(json['name']),
      phoneNo: serializer.fromJson<int>(json['phoneNo']),
      deviceID: serializer.fromJson<String>(json['deviceID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeID': serializer.toJson<String>(employeeID),
      'name': serializer.toJson<String>(name),
      'phoneNo': serializer.toJson<int>(phoneNo),
      'deviceID': serializer.toJson<String>(deviceID),
    };
  }

  Employee copyWith(
          {String employeeID, String name, int phoneNo, String deviceID}) =>
      Employee(
        employeeID: employeeID ?? this.employeeID,
        name: name ?? this.name,
        phoneNo: phoneNo ?? this.phoneNo,
        deviceID: deviceID ?? this.deviceID,
      );
  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('employeeID: $employeeID, ')
          ..write('name: $name, ')
          ..write('phoneNo: $phoneNo, ')
          ..write('deviceID: $deviceID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(employeeID.hashCode,
      $mrjc(name.hashCode, $mrjc(phoneNo.hashCode, deviceID.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Employee &&
          other.employeeID == this.employeeID &&
          other.name == this.name &&
          other.phoneNo == this.phoneNo &&
          other.deviceID == this.deviceID);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<String> employeeID;
  final Value<String> name;
  final Value<int> phoneNo;
  final Value<String> deviceID;
  const EmployeesCompanion({
    this.employeeID = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNo = const Value.absent(),
    this.deviceID = const Value.absent(),
  });
  EmployeesCompanion.insert({
    @required String employeeID,
    this.name = const Value.absent(),
    this.phoneNo = const Value.absent(),
    this.deviceID = const Value.absent(),
  }) : employeeID = Value(employeeID);
  static Insertable<Employee> custom({
    Expression<String> employeeID,
    Expression<String> name,
    Expression<int> phoneNo,
    Expression<String> deviceID,
  }) {
    return RawValuesInsertable({
      if (employeeID != null) 'employee_i_d': employeeID,
      if (name != null) 'name': name,
      if (phoneNo != null) 'phone_no': phoneNo,
      if (deviceID != null) 'device_i_d': deviceID,
    });
  }

  EmployeesCompanion copyWith(
      {Value<String> employeeID,
      Value<String> name,
      Value<int> phoneNo,
      Value<String> deviceID}) {
    return EmployeesCompanion(
      employeeID: employeeID ?? this.employeeID,
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      deviceID: deviceID ?? this.deviceID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeID.present) {
      map['employee_i_d'] = Variable<String>(employeeID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNo.present) {
      map['phone_no'] = Variable<int>(phoneNo.value);
    }
    if (deviceID.present) {
      map['device_i_d'] = Variable<String>(deviceID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('employeeID: $employeeID, ')
          ..write('name: $name, ')
          ..write('phoneNo: $phoneNo, ')
          ..write('deviceID: $deviceID')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  final GeneratedDatabase _db;
  final String _alias;
  $EmployeesTable(this._db, [this._alias]);
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
    return GeneratedTextColumn('name', $tableName, true, maxTextLength: 100);
  }

  final VerificationMeta _phoneNoMeta = const VerificationMeta('phoneNo');
  GeneratedIntColumn _phoneNo;
  @override
  GeneratedIntColumn get phoneNo => _phoneNo ??= _constructPhoneNo();
  GeneratedIntColumn _constructPhoneNo() {
    return GeneratedIntColumn(
      'phone_no',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deviceIDMeta = const VerificationMeta('deviceID');
  GeneratedTextColumn _deviceID;
  @override
  GeneratedTextColumn get deviceID => _deviceID ??= _constructDeviceID();
  GeneratedTextColumn _constructDeviceID() {
    return GeneratedTextColumn(
      'device_i_d',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [employeeID, name, phoneNo, deviceID];
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
    }
    if (data.containsKey('phone_no')) {
      context.handle(_phoneNoMeta,
          phoneNo.isAcceptableOrUnknown(data['phone_no'], _phoneNoMeta));
    }
    if (data.containsKey('device_i_d')) {
      context.handle(_deviceIDMeta,
          deviceID.isAcceptableOrUnknown(data['device_i_d'], _deviceIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeID};
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
    this.attendanceCount = const Value.absent(),
    this.lastAttendance = const Value.absent(),
  }) : employeeID = Value(employeeID);
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
    return GeneratedIntColumn('attendance_count', $tableName, false,
        defaultValue: const Constant(0));
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
  final String key;
  final DateTime eventTime;
  final String eventType;
  final String deviceIDA;
  final String deviceIDB;
  Event(
      {@required this.key,
      @required this.eventTime,
      @required this.eventType,
      @required this.deviceIDA,
      this.deviceIDB});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Event(
      key: stringType.mapFromDatabaseResponse(data['${effectivePrefix}key']),
      eventTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_time']),
      eventType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}event_type']),
      deviceIDA: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}device_i_d_a']),
      deviceIDB: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}device_i_d_b']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || key != null) {
      map['key'] = Variable<String>(key);
    }
    if (!nullToAbsent || eventTime != null) {
      map['event_time'] = Variable<DateTime>(eventTime);
    }
    if (!nullToAbsent || eventType != null) {
      map['event_type'] = Variable<String>(eventType);
    }
    if (!nullToAbsent || deviceIDA != null) {
      map['device_i_d_a'] = Variable<String>(deviceIDA);
    }
    if (!nullToAbsent || deviceIDB != null) {
      map['device_i_d_b'] = Variable<String>(deviceIDB);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      key: key == null && nullToAbsent ? const Value.absent() : Value(key),
      eventTime: eventTime == null && nullToAbsent
          ? const Value.absent()
          : Value(eventTime),
      eventType: eventType == null && nullToAbsent
          ? const Value.absent()
          : Value(eventType),
      deviceIDA: deviceIDA == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceIDA),
      deviceIDB: deviceIDB == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceIDB),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      key: serializer.fromJson<String>(json['key']),
      eventTime: serializer.fromJson<DateTime>(json['eventTime']),
      eventType: serializer.fromJson<String>(json['eventType']),
      deviceIDA: serializer.fromJson<String>(json['deviceIDA']),
      deviceIDB: serializer.fromJson<String>(json['deviceIDB']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'eventTime': serializer.toJson<DateTime>(eventTime),
      'eventType': serializer.toJson<String>(eventType),
      'deviceIDA': serializer.toJson<String>(deviceIDA),
      'deviceIDB': serializer.toJson<String>(deviceIDB),
    };
  }

  Event copyWith(
          {String key,
          DateTime eventTime,
          String eventType,
          String deviceIDA,
          String deviceIDB}) =>
      Event(
        key: key ?? this.key,
        eventTime: eventTime ?? this.eventTime,
        eventType: eventType ?? this.eventType,
        deviceIDA: deviceIDA ?? this.deviceIDA,
        deviceIDB: deviceIDB ?? this.deviceIDB,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('key: $key, ')
          ..write('eventTime: $eventTime, ')
          ..write('eventType: $eventType, ')
          ..write('deviceIDA: $deviceIDA, ')
          ..write('deviceIDB: $deviceIDB')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      key.hashCode,
      $mrjc(
          eventTime.hashCode,
          $mrjc(eventType.hashCode,
              $mrjc(deviceIDA.hashCode, deviceIDB.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.key == this.key &&
          other.eventTime == this.eventTime &&
          other.eventType == this.eventType &&
          other.deviceIDA == this.deviceIDA &&
          other.deviceIDB == this.deviceIDB);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<String> key;
  final Value<DateTime> eventTime;
  final Value<String> eventType;
  final Value<String> deviceIDA;
  final Value<String> deviceIDB;
  const EventsCompanion({
    this.key = const Value.absent(),
    this.eventTime = const Value.absent(),
    this.eventType = const Value.absent(),
    this.deviceIDA = const Value.absent(),
    this.deviceIDB = const Value.absent(),
  });
  EventsCompanion.insert({
    @required String key,
    @required DateTime eventTime,
    this.eventType = const Value.absent(),
    @required String deviceIDA,
    this.deviceIDB = const Value.absent(),
  })  : key = Value(key),
        eventTime = Value(eventTime),
        deviceIDA = Value(deviceIDA);
  static Insertable<Event> custom({
    Expression<String> key,
    Expression<DateTime> eventTime,
    Expression<String> eventType,
    Expression<String> deviceIDA,
    Expression<String> deviceIDB,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (eventTime != null) 'event_time': eventTime,
      if (eventType != null) 'event_type': eventType,
      if (deviceIDA != null) 'device_i_d_a': deviceIDA,
      if (deviceIDB != null) 'device_i_d_b': deviceIDB,
    });
  }

  EventsCompanion copyWith(
      {Value<String> key,
      Value<DateTime> eventTime,
      Value<String> eventType,
      Value<String> deviceIDA,
      Value<String> deviceIDB}) {
    return EventsCompanion(
      key: key ?? this.key,
      eventTime: eventTime ?? this.eventTime,
      eventType: eventType ?? this.eventType,
      deviceIDA: deviceIDA ?? this.deviceIDA,
      deviceIDB: deviceIDB ?? this.deviceIDB,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (eventTime.present) {
      map['event_time'] = Variable<DateTime>(eventTime.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (deviceIDA.present) {
      map['device_i_d_a'] = Variable<String>(deviceIDA.value);
    }
    if (deviceIDB.present) {
      map['device_i_d_b'] = Variable<String>(deviceIDB.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('key: $key, ')
          ..write('eventTime: $eventTime, ')
          ..write('eventType: $eventType, ')
          ..write('deviceIDA: $deviceIDA, ')
          ..write('deviceIDB: $deviceIDB')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventsTable(this._db, [this._alias]);
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  GeneratedTextColumn _key;
  @override
  GeneratedTextColumn get key => _key ??= _constructKey();
  GeneratedTextColumn _constructKey() {
    return GeneratedTextColumn(
      'key',
      $tableName,
      false,
    );
  }

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

  final VerificationMeta _eventTypeMeta = const VerificationMeta('eventType');
  GeneratedTextColumn _eventType;
  @override
  GeneratedTextColumn get eventType => _eventType ??= _constructEventType();
  GeneratedTextColumn _constructEventType() {
    return GeneratedTextColumn('event_type', $tableName, false,
        defaultValue: const Constant('attendance'));
  }

  final VerificationMeta _deviceIDAMeta = const VerificationMeta('deviceIDA');
  GeneratedTextColumn _deviceIDA;
  @override
  GeneratedTextColumn get deviceIDA => _deviceIDA ??= _constructDeviceIDA();
  GeneratedTextColumn _constructDeviceIDA() {
    return GeneratedTextColumn(
      'device_i_d_a',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deviceIDBMeta = const VerificationMeta('deviceIDB');
  GeneratedTextColumn _deviceIDB;
  @override
  GeneratedTextColumn get deviceIDB => _deviceIDB ??= _constructDeviceIDB();
  GeneratedTextColumn _constructDeviceIDB() {
    return GeneratedTextColumn(
      'device_i_d_b',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [key, eventTime, eventType, deviceIDA, deviceIDB];
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
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key'], _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('event_time')) {
      context.handle(_eventTimeMeta,
          eventTime.isAcceptableOrUnknown(data['event_time'], _eventTimeMeta));
    } else if (isInserting) {
      context.missing(_eventTimeMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type'], _eventTypeMeta));
    }
    if (data.containsKey('device_i_d_a')) {
      context.handle(
          _deviceIDAMeta,
          deviceIDA.isAcceptableOrUnknown(
              data['device_i_d_a'], _deviceIDAMeta));
    } else if (isInserting) {
      context.missing(_deviceIDAMeta);
    }
    if (data.containsKey('device_i_d_b')) {
      context.handle(
          _deviceIDBMeta,
          deviceIDB.isAcceptableOrUnknown(
              data['device_i_d_b'], _deviceIDBMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
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

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
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
