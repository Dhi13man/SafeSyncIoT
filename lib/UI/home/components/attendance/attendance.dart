import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/attendance/components/attendanceList.dart';
import 'package:safe_sync/UI/safesyncAlerts.dart';

class InfoText extends StatelessWidget {
  final String _text;

  const InfoText(this._text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(3.0),
      margin: const EdgeInsets.only(top: 10.0),
      child: Text(
        this._text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

class ResetAttendancesButton extends StatelessWidget {
  const ResetAttendancesButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 50,
      child: CupertinoButton(
        color: importantConstants.bgGradBegin,
        child: Text(
          'Reset Attendances',
          style: TextStyle(
            fontSize: 15,
            color: importantConstants.textLightestColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => safeSyncAlerts.showResetAlert('Attendance', context),
      ),
    );
  }
}

class AttendanceTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(
          top: 20,
          bottom: 13,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InfoText('Present: '),
            AttendanceList('present'),
            InfoText('Absent: '),
            AttendanceList('absent'),
            ResetAttendancesButton(),
          ],
        ),
      ),
    );
  }
}
