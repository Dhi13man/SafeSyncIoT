import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/attendance/components/attendanceCard.dart';
import 'package:safe_sync/UI/safesyncAlerts.dart';

class InfoText extends StatelessWidget {
  final String _text;

  const InfoText(this._text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 10.0),
      child: Text(
        this._text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

class AttendanceList extends StatelessWidget {
  StreamBuilder<List<EmployeesWithAttendance>> _buildEmployeeList(
      BuildContext context, String criteria) {
    DataBloc bloc = context.watch<DataBloc>();
    Stream<List<EmployeesWithAttendance>> watchStream;

    if (criteria == 'present')
      watchStream = bloc.getEmployeesWithAttendance(1, boundType: 'lower');
    else if (criteria == 'absent')
      watchStream = bloc.getEmployeesWithAttendance(0, boundType: 'upper');
    else
      watchStream = bloc.getEmployeesWithAttendance(5, boundType: 'lower');

    return StreamBuilder<List<EmployeesWithAttendance>>(
      stream: watchStream,
      builder: (_context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Text('...'),
          );

        // Nobody in given Criteria Found
        List<EmployeesWithAttendance> employeeAttendances = snapshot.data;
        if (employeeAttendances.isEmpty)
          return Text(
            "Nobody is $criteria!",
            style: TextStyle(
                color: importantConstants.textLightColor,
                fontWeight: FontWeight.bold),
          );

        return Expanded(
          child: ListView.builder(
            itemCount: employeeAttendances.length,
            itemBuilder: (BuildContext _context, int index) {
              // Sanitizing Station attendance not needed
              if (employeeAttendances[index].employee.deviceID ==
                  'safesync-iot-sanitize')
                return Container(
                  height: 0,
                  width: 0,
                );
              return AttendanceCard(
                employee: employeeAttendances[index].employee,
                attendance: employeeAttendances[index].attendance,
                key: ValueKey(
                  employeeAttendances[index].employee.employeeID,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InfoText('Present: '),
        _buildEmployeeList(context, 'present'),
        InfoText('Absent: '),
        _buildEmployeeList(context, 'absent'),
        Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          child: CupertinoButton(
            color: importantConstants.bgGradMid,
            child: Text(
              'Reset Attendances',
              style: TextStyle(
                fontSize: 15,
                color: importantConstants.textLightestColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () =>
                safeSyncAlerts.showResetAlert('Attendance', context),
          ),
        ),
      ],
    );
  }
}
