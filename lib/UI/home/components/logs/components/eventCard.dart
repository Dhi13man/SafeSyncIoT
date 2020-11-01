import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:safe_sync/Backend/Database/datafiles/dataClasses.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Stream associatedEmployees;
  const EventCard({Key key, this.event, this.associatedEmployees})
      : super(key: key);

  Icon _getIcon() {
    if (event.eventType == 'register')
      return Icon(
        CupertinoIcons.person_add_solid,
        color: Colors.blue[900],
      );
    else if (event.eventType == 'attendance')
      return Icon(
        CupertinoIcons.checkmark_circle_fill,
        color: Colors.green,
      );
    else if (event.eventType == 'contact')
      return Icon(
        Icons.warning_amber_outlined,
        color: Colors.red[900],
      );
    else if (event.eventType == 'join')
      return Icon(
        Icons.plus_one,
        color: Colors.yellow,
      );
    else
      return Icon(
        CupertinoIcons.question_circle,
        color: Colors.black,
      );
  }

  Widget _infoString() {
    if (event.eventType == 'register')
      return Text(
        'ID ${event.employeeIDA} was added',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      );
    else if (event.eventType == 'attendance')
      return Text(
        'ID ${event.employeeIDA} just sanitized',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      );
    else if (event.eventType == 'contact')
      return StreamBuilder<EventWithEmployees>(
        stream: associatedEmployees,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          final EventWithEmployees data = snapshot.data;
          return Container(
            child: Text(
              '${data.employeeA.name} and ${data.employeeB.name} came into contact!',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          );
        },
      );
    else if (event.eventType == 'join')
      return Text(
        '${event.employeeIDA} device connected',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      );
    else
      return Text(
        'Unknown Event',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
              flex: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: _infoString(),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                child: Text('${event.eventTime}',
                    style: TextStyle(
                        fontSize: (kIsWeb) ? 9 : 5.5,
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
