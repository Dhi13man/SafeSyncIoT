import 'package:flutter/widgets.dart';
export 'package:provider/provider.dart';

class HomeTabState extends ChangeNotifier {
  int _homeTabID = 2;
  int get homeTabID => _homeTabID;

  void openTab(int idResponse) {
    _homeTabID = idResponse;
    notifyListeners();
  }
}
