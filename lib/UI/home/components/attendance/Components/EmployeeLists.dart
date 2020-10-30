import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_sync/Backend/Database/mobileDatabase.dart';
import 'package:safe_sync/Backend/Database/webDatabase.dart';

import 'package:safe_sync/Backend/Database/sharedDatabase.dart';
import 'package:safe_sync/UI/home/components/attendance/Components/employeecard.dart';

class EmployeeList extends StatelessWidget {
  StreamBuilder<List<Employee>> _buildEmployeeList(
      BuildContext context, String criteria) {
    SharedDatabase database;

    if (kIsWeb)
      database = WebDb();
    else
      database = Provider.of<MobileDb>(context);

    Stream<List<Employee>> watchStream;

    if (criteria == 'present')
      watchStream = database.watchAttendaceEmployeeGreater(1);
    else if (criteria == 'absent')
      watchStream = database.watchAttendaceEmployeeLesser(0);
    else
      watchStream = database.watchAttendaceEmployeeGreater(5);

    return StreamBuilder(
      stream: watchStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Employee> employees = snapshot.data ?? List();
        if (employees.length == 0) return Text("No data found.");
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext _, int index) {
            return EmployeeCard(
              employeeName: employees[index].name,
              attendanceCount: index,
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
