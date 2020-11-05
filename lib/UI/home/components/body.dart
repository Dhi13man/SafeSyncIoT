import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/home/components/attendance/attendance.dart';
import 'package:safe_sync/UI/home/components/logs/logs.dart';
import 'package:safe_sync/UI/home/components/menu_list.dart';
import 'package:safe_sync/UI/home/components/statistics/statistics.dart';

class HomeBody extends StatefulWidget {
  final String title;
  HomeBody({Key key, this.title});

  @override
  _HomeBodyState createState() => _HomeBodyState(title: title);
}

class _HomeBodyState extends State<HomeBody> {
  final String title;
  _HomeBodyState({this.title});

  int tabID = 0;
  void _openTab(int idResponse) {
    setState(() {
      tabID = idResponse;
    });
  }

  final List<Widget> _selectedWidget = [
    RealTimeLogs(),
    AttendanceTracker(),
    EmployeeStatistics()
  ];

  @override
  Widget build(BuildContext context) {
    DataBloc bloc = context.bloc<DataBloc>();

    Size _dimensions = MediaQuery.of(context).size;
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(
                top: (importantConstants.onSmallerScreen) ? 25 : 20),
            height: _dimensions.height,
            width: _dimensions.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                DatabaseExtractButton(type: 'Employees', bloc: bloc),
                DatabaseExtractButton(type: 'Attendances', bloc: bloc),
                DatabaseExtractButton(type: 'Events', bloc: bloc),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 8,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: _dimensions.width,
                    child: MenuList(
                      tabSelect: _openTab,
                      selectedTab: tabID,
                    ),
                  ),
                  Expanded(
                    // SWIPE TO CHANGE TAP CAPABILITY
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (kIsWeb) return;
                        if (!Platform.isAndroid && !Platform.isIOS) return;
                        if (details.primaryVelocity > 0)
                          _openTab((tabID != 0) ? tabID - 1 : tabID);
                        else if (details.primaryVelocity < 0)
                          _openTab((tabID != 2) ? tabID + 1 : tabID);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0, color: Colors.white),
                        ),
                        width: _dimensions.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: _selectedWidget[tabID],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DatabaseExtractButton extends StatelessWidget {
  const DatabaseExtractButton({
    Key key,
    @required this.bloc,
    @required this.type,
  }) : super(key: key);

  final DataBloc bloc;
  final String type;

  @override
  Widget build(BuildContext context) {
    String _directory = (importantConstants.onSmallerScreen)
        ? 'App Data Folder'
        : 'Downloads Folder';
    String _tooltip = 'Save $type to $_directory.';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
      child: Container(
        child: Column(
          children: [
            IconButton(
              tooltip: _tooltip,
              icon: Icon(
                Icons.cloud_download_outlined,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                if (type == 'Employees')
                  bloc.exportDatabase(
                      getEmployees: true,
                      getAttendances: false,
                      getEvents: false);
                else if (type == 'Attendances')
                  bloc.exportDatabase(
                      getEmployees: false,
                      getAttendances: true,
                      getEvents: false);
                else if (type == 'Events')
                  bloc.exportDatabase(
                      getEmployees: false,
                      getAttendances: false,
                      getEvents: true);
              },
            ),
            Text(
              type,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
