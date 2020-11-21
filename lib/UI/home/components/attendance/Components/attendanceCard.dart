import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

class AttendanceCard extends StatelessWidget {
  final int optimumAttendancesNumber = 5;
  final Attendance attendance;
  final Employee employee;
  const AttendanceCard({Key key, this.employee, this.attendance})
      : super(key: key);

  Icon _getIcon() {
    if (attendance.attendanceCount < 1)
      return Icon(
        CupertinoIcons.exclamationmark_circle_fill,
        color: Colors.red[900],
      );
    else if (attendance.attendanceCount < optimumAttendancesNumber)
      return Icon(
        CupertinoIcons.checkmark_circle_fill,
        color: Colors.green[900],
      );
    else
      return Icon(
        CupertinoIcons.checkmark_circle_fill,
        color: Colors.indigo[600],
      );
  }

  @override
  Widget build(BuildContext context) {
    String _lastAttendance;
    if (attendance.lastAttendance == null)
      _lastAttendance = 'Unsanitized';
    else {
      _lastAttendance = attendance.lastAttendance.toString();
      _lastAttendance =
          _lastAttendance.substring(0, _lastAttendance.length - 4);
    }
    return Card(
      shadowColor: _getIcon().color,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _getIcon().color),
        borderRadius: BorderRadius.circular(10),
      ),
      borderOnForeground: false,
      child: RawMaterialButton(
        splashColor: _getIcon().color,
        elevation: 5,
        onPressed: () => Navigator.pushNamed(context, '/employeeManage/add',
            arguments: employee),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 1, child: _getIcon()),
              Container(
                child: importantConstants.cardText(
                  '${employee.name}',
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: importantConstants.cardSubText(
                          'ID: ${employee.employeeID}',
                        ),
                      ),
                      importantConstants.cardSubText(
                        '${attendance.attendanceCount} Sanitizations',
                        style: TextStyle(
                            fontSize:
                                (importantConstants.onMobileScreen) ? 7 : 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[900]),
                      ),
                      importantConstants.cardSubText('Last: $_lastAttendance'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
