import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/attendance/components/attendanceCard.dart';

class AttendanceList extends StatelessWidget {
  final String _criteria;

  const AttendanceList(this._criteria, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataBloc bloc = context.watch<DataBloc>();
    Stream<List<EmployeesWithAttendance>> watchStream;

    if (_criteria == 'present')
      watchStream = bloc.getEmployeesWithAttendance(1, boundType: 'lower');
    else if (_criteria == 'absent')
      watchStream = bloc.getEmployeesWithAttendance(0, boundType: 'upper');
    else
      watchStream = bloc.getEmployeesWithAttendance(5, boundType: 'lower');

    return StreamBuilder<List<EmployeesWithAttendance>>(
      stream: watchStream,
      builder: (_context, snapshot) {
        return Expanded(
          child: AnimatedCrossFade(
            firstChild: Text('...'),
            secondChild: Builder(
              builder: (_context) {
                if (!snapshot.hasData) return Text('...');

                // Nobody in given Criteria Found
                List<EmployeesWithAttendance> employeeAttendances =
                    snapshot.data;
                if (employeeAttendances.isEmpty)
                  return Text(
                    "Nobody is $_criteria!",
                    style: TextStyle(
                        color: importantConstants.textLightColor,
                        fontWeight: FontWeight.bold),
                  );

                return ListView.builder(
                  itemCount: employeeAttendances.length,
                  itemBuilder: (BuildContext _context, int index) {
                    // Sanitizing Station attendance not needed
                    if (employeeAttendances[index].employee.deviceID ==
                        'safesync-iot-sanitize') return Container();
                    return AttendanceCard(
                      employee: employeeAttendances[index].employee,
                      attendance: employeeAttendances[index].attendance,
                      key: ValueKey(
                        employeeAttendances[index].employee.employeeID,
                      ),
                    );
                  },
                );
              },
            ),
            duration: Duration(milliseconds: 200),
            crossFadeState: (snapshot.hasData)
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        );
      },
    );
  }
}
