import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

class EventCard extends StatelessWidget {
  final Map<String, Employee> employees;
  final Event _event;
  EventCard(this._event, {Key key, this.employees}) : super(key: key);

  Icon _getIcon() {
    if (_event.eventType == 'register')
      return Icon(
        CupertinoIcons.person_add,
        color: Colors.blue[900],
      );
    else if (_event.eventType == 'attendance')
      return Icon(
        Icons.clean_hands,
        color: Colors.green[800],
      );
    else if (_event.eventType == 'contact')
      return Icon(
        Icons.group,
        color: Colors.amber,
      );
    else if (_event.eventType == 'danger')
      return Icon(
        Icons.warning_amber_outlined,
        color: Colors.red[900],
      );
    else
      return Icon(
        CupertinoIcons.question_circle,
        color: Colors.black,
      );
  }

  Widget _infoString(BuildContext context, String _nameA, String _nameB) {
    if (_event.eventType == 'register')
      return importantConstants.cardText(
        '$_nameA was added',
      );
    else if (_event.eventType == 'attendance')
      return importantConstants.cardText(
        '$_nameA sanitized!',
      );
    else if (_event.eventType == 'contact')
      return importantConstants.cardText(
        '$_nameA and $_nameB came into contact!',
      );
    else if (_event.eventType == 'danger')
      return importantConstants.cardText(
        '$_nameA and $_nameB were in contact for too long!',
      );
    else
      return importantConstants.cardText(
        'Unknown Event',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      );
  }

  @override
  Widget build(BuildContext context) {
    String _dateTime = _event.eventTime.toString();

    String _nameA, _nameB;
    // Handle bad info in database
    if (employees['A'] == null)
      _nameA = '{Device sending data not found in employee database}';
    else
      _nameA = employees['A'].name;
    if (employees['B'] == null)
      _nameB = '{Device being detected not found in employee database}';
    else
      _nameB = employees['B'].name;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (employees['A'] != null)
            Navigator.pushNamed(context, '/employeeManage/add',
                arguments: employees['A']);
        },
        onDoubleTap: () {
          if (employees['B'] != null)
            Navigator.pushNamed(context, '/employeeManage/add',
                arguments: employees['B']);
        },
        child: Tooltip(
          waitDuration: Duration(milliseconds: 500),
          message: (employees['B'] == null)
              ? 'Click to open $_nameA.'
              : 'Click to open $_nameA, Double Click to open $_nameB.',
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            shadowColor: _getIcon().color,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            borderOnForeground: false,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 1, child: _getIcon()),
                  _infoString(context, _nameA, _nameB),
                  Flexible(
                    flex: 2,
                    child: Container(
                      child: Text(
                        '${_dateTime.substring(0, _dateTime.length - 4)}',
                        style: TextStyle(
                            fontSize:
                                (importantConstants.onMobileScreen) ? 5.5 : 9,
                            fontWeight: FontWeight.w600,
                            color: importantConstants.textLighterColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
