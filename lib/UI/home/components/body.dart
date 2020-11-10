import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
    Color _endBodyGradient;
    if (tabID == 0)
      _endBodyGradient = Colors.purple[50];
    else if (tabID == 1)
      _endBodyGradient = Colors.red[50];
    else
      _endBodyGradient = Colors.white;
    Size _dimensions = MediaQuery.of(context).size;
    return Container(
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
                  if (!importantConstants.onMobileScreen) return;
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: _selectedWidget[tabID],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
