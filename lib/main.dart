import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/Database/shared.dart';

import 'package:safe_sync/UI/ContactPage/contactPage.dart';
import 'package:safe_sync/UI/EmployeeManage/components/employeeAdd.dart';
import 'package:safe_sync/UI/EmployeeManage/employeeManage.dart';
import 'package:safe_sync/UI/home/home.dart';

void main() => runApp(SafeSyncApp());

// flutter packages pub run build_runner watch
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

    // Initialize Database based on OS
    return RepositoryProvider<Database>(
      create: (context) => createDb(),
      child: BlocProvider<DataBloc>(
        create: (context) {
          final database = RepositoryProvider.of<Database>(context);
          return DataBloc(database);
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SafeSync IoT',
          routes: {
            '/': (context) => BlocProvider.value(
                value: BlocProvider.of<DataBloc>(context),
                child: SafeSyncHomePage(title: 'SafeSync IoT Dashboard')),
            '/employeeManage': (context) => BlocProvider.value(
                value: BlocProvider.of<DataBloc>(context),
                child: EmployeeManagement()),
            '/employeeManage/add': (context) => BlocProvider.value(
                value: BlocProvider.of<DataBloc>(context),
                child: EmployeeAdd()),
            '/contact': (context) => BlocProvider.value(
                value: BlocProvider.of<DataBloc>(context),
                child: ContactPage()),
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    );
  }
}
