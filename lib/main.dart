import 'package:flutter/material.dart';

import 'Backend/constants.dart';
import 'home/body.dart';

void main() => runApp(MyApp());

// flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8989
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeSync IoT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SafeSync IoT Dashboard'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: importantConstants.bgGradDecoration,
        child: HomeBody(
          title: title,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: () => {},
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
