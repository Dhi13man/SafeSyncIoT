import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';

import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/Home/components/attendance/Components/infoText.dart';
import 'package:safe_sync/UI/Home/components/attendance/components/attendanceCard.dart';

class AttendanceList extends StatelessWidget {
  BlocBuilder<DataBloc, ChangeStack> _buildEmployeeList(
      BuildContext context, String criteria) {
    DataBloc bloc = context.watch<DataBloc>();
    Stream<List<EmployeesWithAttendance>> watchStream;

    if (criteria == 'present')
      watchStream = bloc.getEmployeesWithAttendance(1, boundType: 'lower');
    else if (criteria == 'absent')
      watchStream = bloc.getEmployeesWithAttendance(0, boundType: 'upper');
    else
      watchStream = bloc.getEmployeesWithAttendance(5, boundType: 'lower');

    return BlocBuilder<DataBloc, ChangeStack>(
      builder: (_context, cs) {
        return StreamBuilder<List<EmployeesWithAttendance>>(
            stream: watchStream,
            builder: (_context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

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
                    );
                  },
                ),
              );
            });
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
        Expanded(
          child: Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                color: importantConstants.bgGradMid,
                child: Text('Reset Attendances',
                    style: TextStyle(
                      fontSize: 15,
                      color: importantConstants.textLightestColor,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () => context.read<DataBloc>().resetAllAttendances(),
              )),
        ),
      ],
    );
  }
}
