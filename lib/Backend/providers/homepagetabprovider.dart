import 'package:flutter/widgets.dart';
export 'package:provider/provider.dart';

class HomeTabState extends ChangeNotifier {
  int _homeTabID;
  int get homeTabID => _homeTabID;

  HomeTabState() {
    _homeTabID = 2;
  }

  void openTab(int idResponse) {
    _homeTabID = idResponse;
    notifyListeners();
  }
}
