import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';

class AlertButtonText extends StatelessWidget {
  final String text;
  const AlertButtonText({
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        '$text',
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

Future<dynamic> showResetAlert(String resetTableName, BuildContext context) {
  // RESET FUNCTION
  void _reset(Map<String, bool> _getTable, DataBloc bloc) {
    if (_getTable['Employee'])
      bloc.clear();
    else if (_getTable['Attendance'])
      bloc.resetAllAttendances();
    else if (_getTable['Event']) bloc.clearEvents();
  }

  // So only selected table is saved
  Map<String, bool> _getTable = {
    'Employee': false,
    'Attendance': false,
    'Event': false
  };
  _getTable[resetTableName] = true;
  DataBloc bloc = context.read<DataBloc>();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text(
          'Confirm $resetTableName Reset',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure about Resetting ${resetTableName}s?',
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
                _reset(_getTable, bloc);
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: AlertButtonText(text: "Save ${resetTableName}s and Reset"),
              color: importantConstants.bgGradBegin,
              onPressed: () {
                Future<bool> _result = bloc.exportDatabase(
                  getEmployees: _getTable['Employee'],
                  getAttendances: _getTable['Attendance'],
                  getEvents: _getTable['Event'],
                );
                _reset(_getTable, bloc);
                Navigator.of(context).pop();
                _result.then((value) => importantConstants
                    .showSaveAlert(context, value, type: '${resetTableName}s'));
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
