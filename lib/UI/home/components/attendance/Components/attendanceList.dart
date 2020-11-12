import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';

import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/Home/components/attendance/components/attendanceCard.dart';

class InfoText extends StatelessWidget {
  final String _text;

  const InfoText(this._text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 20.0),
      child: Text(
        this._text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

class AlertButtonText extends StatelessWidget {
  final String text;
  const AlertButtonText({
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Text(
      '$text',
      style: TextStyle(
        fontSize: 13,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AttendanceList extends StatelessWidget {
  BlocBuilder<DataBloc, ChangeStack> _buildEmployeeList(
      BuildContext context, String criteria) {
    DataBloc bloc = context.watch<DataBloc>();
    Stream<List<EmployeesWithAttendance>> watchStream;

    if (criteria == 'present')
      watchStream = bloc.getEmployeesWithAttendance(1, boundType: 'lower');
    else if (criteria == 'absent')
      watchStream = bloc.getEmployeesWithAttendance(0, boundType: 'upper');
    else
      watchStream = bloc.getEmployeesWithAttendance(5, boundType: 'lower');

    return BlocBuilder<DataBloc, ChangeStack>(
      builder: (_context, cs) {
        return StreamBuilder<List<EmployeesWithAttendance>>(
            stream: watchStream,
            builder: (_context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Text('...'),
                );

              // Nobody in given Criteria Found
              List<EmployeesWithAttendance> employeeAttendances = snapshot.data;
              if (employeeAttendances.isEmpty)
                return Text(
                  "Nobody is $criteria!",
                  style: TextStyle(
                      color: importantConstants.textLightColor,
                      fontWeight: FontWeight.bold),
                );

              return Expanded(
                child: ListView.builder(
                  itemCount: employeeAttendances.length,
                  itemBuilder: (BuildContext _context, int index) {
                    // Sanitizing Station attendance not needed
                    if (employeeAttendances[index].employee.deviceID ==
                        'safesync-iot-sanitize')
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    return AttendanceCard(
                      employee: employeeAttendances[index].employee,
                      attendance: employeeAttendances[index].attendance,
                    );
                  },
                ),
              );
            });
      },
    );
  }

  _showResetAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(
            'Confirm Attendance Reset',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure about Resetting Attendances?',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: importantConstants.textLighterColor, fontSize: 20),
          ),
          actionsPadding: EdgeInsets.all(10),
          actions: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: new AlertButtonText(text: "Reset without Saving"),
                color: importantConstants.bgGradBegin,
                onPressed: () {
                  context.read<DataBloc>().resetAllAttendances();
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child:
                    AlertButtonText(text: "Save Today's Attendances and Reset"),
                color: importantConstants.bgGradBegin,
                onPressed: () {
                  DataBloc bloc = context.read<DataBloc>();
                  Future<bool> _result = bloc.exportDatabase(
                      getEmployees: false,
                      getAttendances: true,
                      getEvents: false);
                  bloc.resetAllAttendances();
                  Navigator.of(context).pop();
                  _result.then((value) => importantConstants
                      .showSaveAlert(context, value, type: 'Attendances'));
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: new AlertButtonText(text: "Don't Reset"),
                color: importantConstants.bgGradBegin,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InfoText('Present: '),
        _buildEmployeeList(context, 'present'),
        InfoText('Absent: '),
        _buildEmployeeList(context, 'absent'),
        Expanded(
          child: Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                color: importantConstants.bgGradMid,
                child: Text('Reset Attendances',
                    style: TextStyle(
                      fontSize: 15,
                      color: importantConstants.textLightestColor,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () => _showResetAlert(context),
              )),
        ),
      ],
    );
  }
}
