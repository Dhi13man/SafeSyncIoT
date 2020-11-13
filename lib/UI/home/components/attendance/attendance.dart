import 'package:flutter/material.dart';

import 'package:safe_sync/UI/Home/components/attendance/components/attendanceList.dart';

class AttendanceTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(
        top: 20,
        bottom: 13,
        left: 20,
        right: 20,
      ),
      child: AttendanceList(),
    );
  }
}
