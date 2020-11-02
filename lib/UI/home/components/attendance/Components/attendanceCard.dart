import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

class AttendanceCard extends StatelessWidget {
  final int attendanceCount, optimumAttendancesNumber = 5;
  final Employee employee;
  const AttendanceCard({Key key, this.employee, this.attendanceCount})
      : super(key: key);

  Icon _getIcon() {
    if (attendanceCount < 1)
      return Icon(
        CupertinoIcons.exclamationmark_circle_fill,
        color: Colors.red[900],
      );
    else if (attendanceCount < optimumAttendancesNumber)
      return Icon(
        CupertinoIcons.checkmark_circle_fill,
        color: Colors.green,
      );
    else
      return Icon(
        CupertinoIcons.checkmark_circle_fill,
        color: Colors.indigo[600],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: _getIcon().color,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderOnForeground: false,
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
                    Text('$attendanceCount Attendances',
                        style: TextStyle(
                            fontSize: (kIsWeb) ? 10 : 7,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[900])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
