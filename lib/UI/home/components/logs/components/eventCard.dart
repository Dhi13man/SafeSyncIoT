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
        CupertinoIcons.checkmark_circle_fill,
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

  Widget _infoString() {
    if (_eventAndEmployees.event.eventType == 'register')
      return importantConstants.cardText(
        '${_eventAndEmployees.employeeA.name} was added',
      );
    else if (_eventAndEmployees.event.eventType == 'attendance')
      return importantConstants.cardText(
        '${_eventAndEmployees.employeeA.name} just sanitized',
      );
    else if (_eventAndEmployees.event.eventType == 'contact')
      return Container(
        child: importantConstants.cardText(
          '${_eventAndEmployees.employeeA.name} and ${_eventAndEmployees.employeeB.name} came into contact!',
        ),
      );
    else if (_eventAndEmployees.event.eventType == 'danger')
      return Container(
        child: importantConstants.cardText(
          '${_eventAndEmployees.employeeA.name} and ${_eventAndEmployees.employeeB.name} were in contact for too long!',
        ),
      );
    else
      return importantConstants.cardText(
        'Unknown Event',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
            _infoString(),
            Flexible(
              flex: 2,
              child: Container(
                child: Text('${_eventAndEmployees.event.eventTime}',
                    style: TextStyle(
                        fontSize:
                            (importantConstants.onSmallerScreen) ? 5.5 : 9,
                        fontWeight: FontWeight.w600,
                        color: importantConstants.textLighterColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
