import 'package:flutter/widgets.dart';

import 'package:safe_sync/UI/Home/components/attendance/attendance.dart';
import 'package:safe_sync/UI/Home/components/logs/logs.dart';
import 'package:safe_sync/UI/Home/components/statistics/statistics.dart';

export 'package:provider/provider.dart';

class HomeTabState extends ChangeNotifier {
  int _homeTabID;
  int get homeTabID => _homeTabID;
  final Widget _logsScreen = RealTimeLogs();
  final Widget _attendancesScreen = AttendanceTracker();
  final Widget _statisticsScreen = EmployeeStatistics();

  HomeTabState() {
    _homeTabID = 2;
  }

  Widget getSelectedWidget() {
    if (_homeTabID == 0)
      return _logsScreen;
    else if (_homeTabID == 1)
      return _attendancesScreen;
    else if (_homeTabID == 2) return _statisticsScreen;
    return Container();
  }

  void openTab(int idResponse) {
    _homeTabID = idResponse;
    notifyListeners();
  }
}
