import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

/// Card that displays an entry and an icon button to delete that entry
class EmployeeCard extends StatelessWidget {
  final Employee entry;

  EmployeeCard(this.entry, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSanitizingStation = entry.deviceID == 'safesync-iot-sanitize';
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: importantConstants.bgGradMid),
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5,
      ),
      shadowColor: importantConstants.bgGradMid,
      child: Tooltip(
        message: (!isSanitizingStation)
            ? 'Click to Edit ${entry.name}'
            : 'Unmodifiable',
        child: RawMaterialButton(
          onPressed: (!isSanitizingStation)
              ? () => Navigator.pushNamed(
                    context,
                    '/employeeManage/add',
                    arguments: entry,
                  )
              : null, // Can't modify Sanitizing Station()
          splashColor: Colors.black,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        icon: const Icon(Icons.delete),
                        color: Colors.black,
                        focusColor: Colors.red,
                        onPressed: () {
                          context.read<DataBloc>().deleteEmployee(entry);
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
