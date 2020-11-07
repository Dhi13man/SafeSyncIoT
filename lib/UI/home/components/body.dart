import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/home/components/attendance/attendance.dart';
import 'package:safe_sync/UI/home/components/logs/logs.dart';
import 'package:safe_sync/UI/home/components/menu_list.dart';
import 'package:safe_sync/UI/home/components/statistics/statistics.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/contact'),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: (importantConstants.onSmallerScreen) ? 12 : 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
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

  _showAlert(BuildContext context, bool _hasSucceeded, String _where) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: FutureBuilder(
            future: importantConstants.fileSavePath(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              String _message = (!_hasSucceeded)
                  ? 'Unable to Save. Check Permissions.'
                  : 'Saved $type in $_where';
              if (!snapshot.hasData)
                return Text(_message);
              else
                return Column(
                  children: [
                    Text('$_message: '),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Text(
                          snapshot.data,
                          style: TextStyle(
                              color: importantConstants.textLighterColor,
                              fontSize: 12),
                        )),
                  ],
                );
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                size: (importantConstants.onSmallerScreen) ? 25 : 35,
                color: Colors.white,
              ),
              onPressed: () {
                Future<bool> _result;
                if (type == 'Employees')
                  _result = bloc.exportDatabase(
                      getEmployees: true,
                      getAttendances: false,
                      getEvents: false);
                else if (type == 'Attendances')
                  _result = bloc.exportDatabase(
                      getEmployees: false,
                      getAttendances: true,
                      getEvents: false);
                else if (type == 'Events')
                  _result = bloc.exportDatabase(
                      getEmployees: false,
                      getAttendances: false,
                      getEvents: true);
                return _result
                    .then((value) => (_showAlert(context, value, _directory)));
              },
            ),
            Text(
              type,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: (importantConstants.onSmallerScreen) ? 8 : 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

    Color _endBodyGradient;
    if (tabID == 0)
      _endBodyGradient = Colors.purple[50];
    else if (tabID == 1)
      _endBodyGradient = Colors.red[50];
    else
      _endBodyGradient = Colors.teal[50];
    Size _dimensions = MediaQuery.of(context).size;
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(
                top: (importantConstants.onSmallerScreen) ? 20 : 15),
            height: _dimensions.height,
            width: _dimensions.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTitleBar(title: title),
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
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                _endBodyGradient,
                              ]),
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
