import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/body.dart';
import 'package:safe_sync/UI/sidebar.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/contact'),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: (importantConstants.onMobileScreen) ? 12 : 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DatabaseExtractButton extends StatelessWidget {
  const DatabaseExtractButton({
    Key key,
    @required this.bloc,
    @required this.type,
  }) : super(key: key);

  final DataBloc bloc;
  final String type;

  @override
  Widget build(BuildContext context) {
    String _where = (importantConstants.onMobileScreen)
        ? 'App Data Folder'
        : 'Downloads Folder';
    String _tooltip = 'Save $type in $_where as CSV.';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
      child: Container(
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
                  _result = bloc.exportDatabase(
                      getEmployees: true,
                      getAttendances: false,
                      getEvents: false);
                else if (type == 'Attendances')
                  _result = bloc.exportDatabase(
                      getEmployees: false,
                      getAttendances: true,
                      getEvents: false);
                else if (type == 'Events')
                  _result = bloc.exportDatabase(
                      getEmployees: false,
                      getAttendances: false,
                      getEvents: true);
                return _result.then((value) => (importantConstants
                    .showSaveAlert(context, value, type: type)));
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

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    DataBloc bloc = context.watch<DataBloc>();

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
                      top: (importantConstants.onMobileScreen) ? 20 : 15),
                  height: _dimensions.height,
                  width: _dimensions.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTitleBar(title: title),
                      DatabaseExtractButton(type: 'Employees', bloc: bloc),
                      DatabaseExtractButton(type: 'Attendances', bloc: bloc),
                      DatabaseExtractButton(type: 'Events', bloc: bloc),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 8,
                child: HomeBody(title: title),
              ),
            ],
          )),
      drawer: SideBarDrawer(context, _drawerKey),
      floatingActionButton: FloatingActionButton(
        elevation: 80,
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
