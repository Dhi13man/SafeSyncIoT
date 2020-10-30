import 'package:flutter/material.dart';

class EmployeeManagement extends StatelessWidget {
  const EmployeeManagement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage your Employees'),
        centerTitle: true,
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text('Employee Management here'),
      ),
    );
  }
}
