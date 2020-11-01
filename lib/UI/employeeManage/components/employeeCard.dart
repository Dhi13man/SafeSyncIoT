import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';

import 'package:safe_sync/Backend/Database/sharedDatabase.dart';
import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/EmployeeManage/components/employeeAdd.dart';

/// Card that displays an entry and an icon button to delete that entry
class EmployeeCard extends StatelessWidget {
  final Employee entry;

  EmployeeCard(this.entry) : super(key: ObjectKey(entry.employeeID));

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ),
                        child: Text(
                          '${entry.name} ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: importantConstants.textColor),
                        ),
                      ),
                      Text(
                        'ID: ${entry.employeeID}',
                        style: TextStyle(
                            fontSize: 9,
                            color: importantConstants.textLighterColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contact: ${entry.phoneNo.toString()}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'DeviceID: ${entry.deviceID}',
                        style: TextStyle(
                            fontSize: 9,
                            color: importantConstants.textLighterColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) => EmployeeAdd(
                    employee: entry,
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                BlocProvider.of<DataBloc>(context).deleteEmployee(entry);
              },
            )
          ],
        ),
      ),
    );
  }
}
