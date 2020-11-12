import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

/// Card that displays an entry and an icon button to delete that entry
class EmployeeCard extends StatelessWidget {
  final Employee entry;

  EmployeeCard(this.entry) : super(key: ObjectKey(entry.employeeID));

  @override
  Widget build(BuildContext context) {
    bool isSanitizingStation = entry.deviceID == 'safesync-iot-sanitize';
    return GestureDetector(
      onTap: () {
        if (!isSanitizingStation) // Can't modify Sanitizing Station
          Navigator.pushNamed(context, '/employeeManage/add', arguments: entry);
      },
      child: Tooltip(
        message: (!isSanitizingStation)
            ? 'Click to Edit ${entry.name}'
            : 'Unmodifiable',
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 10,
          margin: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5,
          ),
          shadowColor: Colors.black,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          importantConstants.cardText(
                            '${entry.name} ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: importantConstants.textColor),
                          ),
                          importantConstants.cardSubText(
                            'ID: ${entry.employeeID}',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          importantConstants.cardText(
                            'Contact: ${entry.phoneNo.toString()}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          importantConstants.cardSubText(
                            'DeviceID: ${entry.deviceID}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                (!isSanitizingStation)
                    ? IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.black,
                        focusColor: Colors.red,
                        onPressed: () {
                          BlocProvider.of<DataBloc>(context)
                              .deleteEmployee(entry);
                        },
                      )
                    : Container(), // NO DELETE BUTTON FOR SANITIZING STATION
              ],
            ),
          ),
        ),
      ),
    );
  }
}
