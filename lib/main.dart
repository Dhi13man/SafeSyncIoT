import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite3/open.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart' as data;
import 'package:safe_sync/Backend/Database/shared.dart';
import 'plugins/desktop/desktop.dart';

import 'package:safe_sync/UI/ContactPage/contactPage.dart';
import 'package:safe_sync/UI/EmployeeManage/components/employeeAdd.dart';
import 'package:safe_sync/UI/EmployeeManage/employeeManage.dart';
import 'package:safe_sync/UI/home/home.dart';

// For Database on Linux
DynamicLibrary _openOnLinux() {
  final script = File(Platform.script.toFilePath());
  print(script.path);
  final libraryNextToScript = File('${script.path}/sqlite3.so');
  return DynamicLibrary.open(libraryNextToScript.path);
}

// For Database on Windows
DynamicLibrary _openOnWindows() {
  final script = File(Platform.script.toFilePath());
  final libraryNextToScript = File('${script.path}/sqlite3.dll');
  return DynamicLibrary.open(libraryNextToScript.path);
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setTargetPlatformForDesktop();
  open.overrideFor(OperatingSystem.linux, _openOnLinux);
  open.overrideFor(OperatingSystem.windows, _openOnWindows);

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }

  runApp(SafeSyncApp());
}

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
