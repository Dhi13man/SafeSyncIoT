import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart' as data;
import 'package:safe_sync/Backend/Database/shared.dart';

import 'package:safe_sync/UI/Home/components/logs/components/contactEventSummary.dart';
import 'package:safe_sync/UI/ContactPage/contactPage.dart';
import 'package:safe_sync/UI/EmployeeManage/components/employeeAdd.dart';
import 'package:safe_sync/UI/EmployeeManage/employeeManage.dart';
import 'package:safe_sync/UI/home/home.dart';

void setUpDatabaseForDesktop() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
}

void main() {
  setUpDatabaseForDesktop();
  runApp(SafeSyncApp());
}

// flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8989

class SafeSyncApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    // Prevent Orientation Changes
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize Database encapsulated by bloc architecture.
    return RepositoryProvider<data.Database>(
      create: (context) => createDb(),
      child: BlocProvider<DataBloc>(
        create: (context) {
          final database = RepositoryProvider.of<data.Database>(context);
          return DataBloc(database);
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SafeSync IoT',
          routes: {
            '/': (context) => BlocProvider.value(
                  value: BlocProvider.of<DataBloc>(context),
                  child: SafeSyncHomePage(title: 'SafeSync IoT Dashboard'),
                ),
            '/employeeManage': (context) => BlocProvider.value(
                  value: BlocProvider.of<DataBloc>(context),
                  child: EmployeeManagement(),
                ),
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/employeeManage/add':
                return PageTransition(
                  child: Builder(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<DataBloc>(context),
                      child: EmployeeAdd(),
                    ),
                  ),
                  type: PageTransitionType.rightToLeftWithFade,
                  settings: settings,
                );
              case '/contactEventSummary':
                return PageTransition(
                  child: Builder(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<DataBloc>(context),
                      child: ContactEventSummary(),
                    ),
                  ),
                  type: PageTransitionType.fade,
                );
              case '/contact':
                return PageTransition(
                  child: Builder(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<DataBloc>(context),
                      child: ContactPage(),
                    ),
                  ),
                  type: PageTransitionType.size,
                  alignment: Alignment.center,
                );
              default:
                return null;
            }
          },
          theme: ThemeData(primarySwatch: Colors.blue),
        ),
      ),
    );
  }
}
