import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

import 'package:safe_sync/Backend/constants.dart';

/// Card that displays an entry and an icon button to delete that entry
class EmployeeCard extends StatelessWidget {
  final Employee entry;

  EmployeeCard(this.entry) : super(key: ObjectKey(entry.employeeID));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/employeeManage/add', arguments: entry);
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
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
        ),
      ),
    );
  }
}
