import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/constants.dart';

class BoredClock extends StatelessWidget {
  const BoredClock({
    Key key,
  }) : super(key: key);

  Stream<String> realTime(BuildContext context) {
    return Stream.periodic(Duration(milliseconds: 100),
        (index) => TimeOfDay.now().format(context));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: realTime(context),
      builder: (_context, snapshot) {
        if (!snapshot.hasData) return Text('');
        return Text(
          snapshot.data,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        );
      },
    );
  }
}

class SidebarTileIcon extends StatelessWidget {
  final IconData iconData;

  const SidebarTileIcon({
    @required this.iconData,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: Colors.black,
    );
  }
}

class SidebarTileText extends StatelessWidget {
  final String text;
  const SidebarTileText({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

class SideBarDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  SideBarDrawer(this._scaffoldKey);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.symmetric(vertical: 40),
            padding: EdgeInsets.symmetric(vertical: 40),
            decoration: importantConstants.bgGradDecoration.copyWith(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'SafeSync Utilities',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: (importantConstants.onMobileScreen) ? 25 : 30.0,
                    letterSpacing: 1.5,
                  ),
                ),
                BoredClock(),
              ],
            ),
          ),
          ListTile(
            leading: SidebarTileIcon(iconData: Icons.group_outlined),
            title: SidebarTileText(text: 'Employee Management'),
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.pushNamed(context, '/employeeManage');
              }
            },
          ),
          ListTile(
            leading: SidebarTileIcon(iconData: Icons.book_rounded),
            title: SidebarTileText(
              text: 'Employee Contact Summary',
            ),
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.pushNamed(context, '/contactEventSummary');
              }
            },
          ),
          ListTile(
            leading: SidebarTileIcon(iconData: Icons.new_releases_rounded),
            title: SidebarTileText(
              text: 'Get Pandemic Updates',
            ),
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
                importantConstants.launchURL(context,
                    'https://www.google.com/search?q=pandemic+news&tbm=nws');
              }
            },
          ),
          ListTile(
            leading: SidebarTileIcon(iconData: Icons.contact_page),
            title: SidebarTileText(
              text: 'Contact us',
            ),
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.pushNamed(context, '/contact');
              }
            },
          ),
        ],
      ),
    );
  }
}
