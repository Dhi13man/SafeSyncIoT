import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';
import 'package:safe_sync/Backend/constants.dart';

class EventCard extends StatelessWidget {
  final EventWithEmployees _eventAndEmployees;
  EventCard(this._eventAndEmployees, {Key key}) : super(key: key);

  Icon _getIcon() {
    if (_eventAndEmployees.event.eventType == 'register')
      return Icon(
        CupertinoIcons.person_add_solid,
        color: Colors.blue[900],
      );
    else if (_eventAndEmployees.event.eventType == 'attendance')
      return Icon(
        Icons.clean_hands_rounded,
        color: Colors.green,
      );
    else if (_eventAndEmployees.event.eventType == 'contact')
      return Icon(
        Icons.group,
        color: Colors.yellow,
      );
    else if (_eventAndEmployees.event.eventType == 'danger')
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

  Widget _infoString(BuildContext context) {
    String _nameA, _nameB;
    // Handle bad info in database
    if (_eventAndEmployees.employeeA == null)
      _nameA = '{device_id_A not found in employee database}';
    else
      _nameA = _eventAndEmployees.employeeA.name;
    if (_eventAndEmployees.employeeB == null)
      _nameB = '{device_id_B not found in employee database}';
    else
      _nameB = _eventAndEmployees.employeeB.name;

    if (_eventAndEmployees.event.eventType == 'register')
      return importantConstants.cardText(
        '$_nameA was added',
      );
    else if (_eventAndEmployees.event.eventType == 'attendance')
      return importantConstants.cardText(
        '$_nameA sanitized!',
      );
    else if (_eventAndEmployees.event.eventType == 'contact')
      return importantConstants.cardText(
        '$_nameA and $_nameB came into contact!',
      );
    else if (_eventAndEmployees.event.eventType == 'danger')
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
    return GestureDetector(
      onTap: () {
        if (_eventAndEmployees.employeeA != null)
          Navigator.pushNamed(context, '/employeeManage/add',
              arguments: _eventAndEmployees.employeeA);
      },
      onDoubleTap: () {
        if (_eventAndEmployees.employeeB != null)
          Navigator.pushNamed(context, '/employeeManage/add',
              arguments: _eventAndEmployees.employeeB);
      },
      child: Card(
        shadowColor: _getIcon().color,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        borderOnForeground: false,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 1, child: _getIcon()),
              _infoString(context),
              Flexible(
                flex: 2,
                child: Container(
                  child: Text('${_eventAndEmployees.event.eventTime}',
                      style: TextStyle(
                          fontSize:
                              (importantConstants.onMobileScreen) ? 5.5 : 9,
                          fontWeight: FontWeight.w600,
                          color: importantConstants.textLighterColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
