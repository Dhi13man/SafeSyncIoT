import 'package:flutter/material.dart';

import 'components/menu_list.dart';
import 'package:safe_sync/attendance/attendance.dart';
import 'package:safe_sync/logs/logs.dart';
import 'package:safe_sync/statistics/statistics.dart';

class HomeBody extends StatefulWidget {
  final String title;
  HomeBody({this.title});

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
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 8,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: _width,
                  child: MenuList(
                    tabSelect: _openTab,
                    selectedTab: tabID,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0, color: Colors.white),
                    ),
                    width: _width,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(child: _selectedWidget[tabID]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
