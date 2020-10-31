import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/home/components/body.dart';
import 'package:safe_sync/UI/sidebar.dart';

class SafeSyncHomePage extends StatelessWidget {
  SafeSyncHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return Scaffold(
      key: _drawerKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: importantConstants.bgGradDecoration,
        child: HomeBody(
          title: title,
        ),
      ),
      drawer: SideBarDrawer(context, _drawerKey),
      floatingActionButton: FloatingActionButton(
        backgroundColor: importantConstants.bgGradBegin,
        foregroundColor: Colors.white,
        autofocus: true,
        focusColor: importantConstants.bgGradEnd,
        tooltip: 'Employee Tools',
        child: Icon(Icons.person),
        onPressed: () {
          _drawerKey.currentState.openDrawer();
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
