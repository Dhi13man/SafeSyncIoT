import 'package:flutter/material.dart';

import 'package:safe_sync/UI/employeeManage/employeeManage.dart';
import 'package:safe_sync/UI/home/home.dart';

void main() => runApp(SafeSyncApp());

// flutter packages pub run build_runner watch
// flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8989
class SafeSyncApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeSync IoT',
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/employeeManage': (context) => EmployeeManagement(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeSyncHomePage(title: 'SafeSync IoT Dashboard'),
    );
  }
}
