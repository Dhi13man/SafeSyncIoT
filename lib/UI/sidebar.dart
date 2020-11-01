import 'package:flutter/material.dart';
import 'package:safe_sync/Backend/constants.dart';

class SideBarDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final BuildContext _mainContext;

  SideBarDrawer(this._mainContext, this._scaffoldKey);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          DrawerHeader(
            decoration: importantConstants.bgGradDecoration,
            child: Center(
              child: Expanded(
                child: Text(
                  'SafeSync Utilities',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.pushNamed(_mainContext, '/employeeManage');
              }
            },
            leading: Icon(
              Icons.group_outlined,
            ),
            title: Text(
              'Employee Management',
            ),
          ),
          ListTile(
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.pushNamed(_mainContext, '/contact');
              }
            },
            leading: Icon(
              Icons.contact_page,
            ),
            title: Text(
              'Contact us',
            ),
          ),
        ],
      ),
    );
  }
}
