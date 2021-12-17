import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/Backend/providers/homepagetabprovider.dart';

import 'package:safe_sync/UI/Home/components/body.dart';
import 'package:safe_sync/UI/safesyncAlerts.dart';
import 'package:safe_sync/UI/sidebar.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final DataBloc bloc = context.watch<DataBloc>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: RawMaterialButton(
        focusColor: Colors.transparent,
        onPressed: () => Navigator.pushNamed(context, '/contact'),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: (importantConstants.onMobileScreen) ? 13 : 22,
                color: Colors.white,
              ),
            ),
            StreamBuilder<String>(
              stream: bloc.server.serverIPTracker.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData)
                  return Text(
                    'Server Listening on ...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (importantConstants.onMobileScreen) ? 7 : 9,
                      color: Colors.white,
                    ),
                  );
                return Text(
                  'Server Listening on ${snapshot.data}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: (importantConstants.onMobileScreen) ? 7 : 9,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseExtractButton extends StatelessWidget {
  const DatabaseExtractButton({
    Key key,
    @required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    DataBloc bloc = context.watch<DataBloc>();
    String _where = (importantConstants.onMobileScreen)
        ? 'App Data Folder'
        : 'Downloads Folder';
    String _tooltip = 'Save $type in $_where as CSV.';
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            IconButton(
              tooltip: _tooltip,
              icon: Icon(
                Icons.cloud_download_outlined,
                size: (importantConstants.onMobileScreen) ? 25 : 35,
                color: Colors.white,
              ),
              onPressed: () {
                Future<bool> _result;
                if (type == 'Employees')
                  _result = bloc.exportDatabase(getEmployees: true);
                else if (type == 'Attendances')
                  _result = bloc.exportDatabase(getAttendances: true);
                else if (type == 'Events')
                  _result = bloc.exportDatabase(getEvents: true);
                return _result.then(
                  (value) => safeSyncAlerts.showSaveAlert(
                    context,
                    value,
                    type: type,
                  ),
                );
              },
            ),
            Text(
              type,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: (importantConstants.onMobileScreen) ? 8 : 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SafeSyncHomePage extends StatelessWidget {
  SafeSyncHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final HomeTabState _state = HomeTabState();

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
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                  top: (importantConstants.onMobileScreen) ? 20 : 15,
                ),
                height: _dimensions.height,
                width: _dimensions.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTitleBar(title: title),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DatabaseExtractButton(type: 'Employees'),
                        DatabaseExtractButton(type: 'Attendances'),
                        DatabaseExtractButton(type: 'Events'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 8,
              child: ChangeNotifierProvider<HomeTabState>.value(
                value: _state,
                child: HomeBody(
                  title: title,
                ),
                builder: (context, child) => child,
              ),
            ),
          ],
        ),
      ),
      drawer: SideBarDrawer(_drawerKey),
      floatingActionButton: FloatingActionButton(
        backgroundColor: importantConstants.bgGradBegin,
        foregroundColor: Colors.white,
        autofocus: true,
        focusColor: importantConstants.bgGradMid,
        tooltip: 'Employee Tools',
        child: Icon(
          Icons.person,
          size: 40,
        ),
        onPressed: () {
          _drawerKey.currentState.openDrawer();
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
