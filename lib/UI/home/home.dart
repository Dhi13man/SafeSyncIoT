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
    Size _dimensions = MediaQuery.of(context).size;
    return Scaffold(
      key: _drawerKey,
      body: Container(
        height: _dimensions.height,
        width: _dimensions.width,
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
        focusColor: Colors.black,
        tooltip: 'Employee Tools',
        child: Icon(
          Icons.person,
          size: 30,
        ),
        onPressed: () {
          _drawerKey.currentState.openDrawer();
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
