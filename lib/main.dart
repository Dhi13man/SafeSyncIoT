import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/mobileDatabase.dart';
import 'package:safe_sync/Backend/Database/sharedDatabase.dart';
import 'package:safe_sync/Backend/Database/webDatabase.dart';

import 'package:safe_sync/UI/EmployeeManage/employeeManage.dart';
import 'package:safe_sync/UI/home/home.dart';
import 'package:safe_sync/UI/ContactPage/contactPage.dart';

void main() => runApp(SafeSyncApp());

// flutter packages pub run build_runner watch
// flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8989
class SafeSyncApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    var db;
    if (kIsWeb)
      db = WebDb();
    else
      db = MobileDb();

    return RepositoryProvider<SharedDatabase>(
      create: (context) => db.create(),
      child: BlocProvider(
        create: (context) {
          final db = RepositoryProvider.of<SharedDatabase>(context);
          return DataBloc(db);
        },
        child: MaterialApp(
          title: 'SafeSync IoT',
          routes: {
            '/employeeManage': (context) => BlocProvider.value(
                value: BlocProvider.of<DataBloc>(context),
                child: EmployeeManagement()),
            '/contact': (context) => BlocProvider.value(
                value: BlocProvider.of<DataBloc>(context),
                child: ContactPage()),
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SafeSyncHomePage(title: 'SafeSync IoT Dashboard'),
        ),
      ),
    );
  }
}
