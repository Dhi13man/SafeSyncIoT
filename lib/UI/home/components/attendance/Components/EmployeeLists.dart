import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/dataClasses.dart';
import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/Home/components/attendance/Components/infoText.dart';

import 'package:safe_sync/UI/home/components/attendance/Components/employeeCard.dart';
import 'package:undo/undo.dart';

class EmployeeList extends StatelessWidget {
  BlocBuilder<DataBloc, ChangeStack> _buildEmployeeList(
      BuildContext context, String criteria) {
    DataBloc bloc = BlocProvider.of<DataBloc>(context);
    Stream<List<EmployeesWithAttendance>> watchStream;

    if (criteria == 'present')
      watchStream = bloc.getEmployeesWithAttendance(1, boundType: 'lower');
    else if (criteria == 'absent')
      watchStream = bloc.getEmployeesWithAttendance(0, boundType: 'upper');
    else
      watchStream = bloc.getEmployeesWithAttendance(5, boundType: 'lower');

    return BlocBuilder<DataBloc, ChangeStack>(
      builder: (context, cs) {
        return StreamBuilder<List<EmployeesWithAttendance>>(
            stream: watchStream,
            builder: (context, snapshot) {
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
                  itemBuilder: (BuildContext context, int index) {
                    return EmployeeCard(
                      employeeName: employeeAttendances[index].employee.name,
                      attendanceCount:
                          employeeAttendances[index].attendance.attendanceCount,
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
      children: [
        InfoText('Present: '),
        _buildEmployeeList(context, 'present'),
        InfoText('Absent: '),
        _buildEmployeeList(context, 'absent'),
      ],
    );
  }
}
