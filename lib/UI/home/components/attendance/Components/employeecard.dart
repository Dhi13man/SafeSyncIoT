import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

class EmployeeCard extends StatelessWidget {
  final int attendanceCount, optimumAttendancesNumber = 5;
  final Employee employee;
  const EmployeeCard({Key key, this.employee, this.attendanceCount})
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
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(flex: 1, child: _getIcon()),
            Flexible(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '${employee.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'ID: ${employee.employeeID}',
                        style: TextStyle(
                            fontSize: 9,
                            color: importantConstants.textLighterColor),
                      ),
                    ),
                    Text('$attendanceCount Attendances',
                        style: TextStyle(
                            fontSize: (kIsWeb) ? 15 : 7,
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
