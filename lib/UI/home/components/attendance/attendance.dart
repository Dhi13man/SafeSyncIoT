import 'package:flutter/material.dart';
import 'package:safe_sync/UI/home/components/attendance/Components/EmployeeLists.dart';

class AttendanceTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: EmployeeList(),
            )
          ],
        ));
  }
}
