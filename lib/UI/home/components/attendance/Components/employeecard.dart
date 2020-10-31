import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EmployeeCard extends StatelessWidget {
  final int attendanceCount, optimumAttendancesNumber = 5;
  final String employeeName;
  const EmployeeCard({Key key, this.employeeName, this.attendanceCount})
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shadowColor: Colors.black38,
          borderOnForeground: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 1, child: _getIcon()),
              Flexible(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(employeeName),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  child: Text('$attendanceCount Attendances',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
