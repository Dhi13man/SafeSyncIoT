import 'package:flutter/material.dart';

import 'package:safe_sync/UI/home/components/attendance/attendance.dart';
import 'package:safe_sync/UI/home/components/logs/logs.dart';
import 'package:safe_sync/UI/home/components/menu_list.dart';
import 'package:safe_sync/UI/home/components/statistics/statistics.dart';

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
    Size _dimensions = MediaQuery.of(context).size;
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            height: _dimensions.height,
            width: _dimensions.width,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
