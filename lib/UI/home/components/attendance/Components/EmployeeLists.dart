import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_sync/Backend/Database/dataClasses.dart';
import 'package:safe_sync/Backend/Database/webDatabase.dart';

import 'package:safe_sync/Backend/Database/sharedDatabase.dart';
import 'package:safe_sync/UI/home/components/attendance/Components/employeecard.dart';

class EmployeeList extends StatelessWidget {
  StreamBuilder<List<EmployeesWithAttendance>> _buildEmployeeList(
      BuildContext context, String criteria) {
    SharedDatabase database;

    if (kIsWeb)
      database = WebDb();
    else
      database = Provider.of<WebDb>(context);

    Stream<List<EmployeesWithAttendance>> watchStream;

    if (criteria == 'present')
      watchStream = database.watchEmployeeAttendaceGreater(1);
    else if (criteria == 'absent')
      watchStream = database.watchEmployeeAttendaceLesser(0);
    else
      watchStream = database.watchEmployeeAttendaceGreater(5);

    return StreamBuilder(
      stream: watchStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<EmployeesWithAttendance> employeeAttendances =
            snapshot.data ?? List();
        if (employeeAttendances.length == 0) return Text("No data found.");
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext _, int index) {
            return EmployeeCard(
              employeeName: employeeAttendances[index].employee.name,
              attendanceCount:
                  employeeAttendances[index].attendance.attendanceCount,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Present: '),
        ),
        _buildEmployeeList(context, 'present'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Absent: '),
        ),
        _buildEmployeeList(context, 'absent'),
      ],
    );
  }
}
