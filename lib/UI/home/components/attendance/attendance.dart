import 'package:flutter/material.dart';
import 'package:safe_sync/UI/home/components/attendance/Components/EmployeeLists.dart';

class AttendanceTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: EmployeeList(),
      ),
    );
  }
}
