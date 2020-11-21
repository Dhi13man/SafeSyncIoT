import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

class EmployeeEventData {
  Employee employee;
  int contacts;
  int dangerousContacts;
  int sanitizations;
}

class ContactEventSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Changes based on whether Adding new or editing.
        title: Text('Summary of Contacts'),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: importantConstants.bgGradDecoration,
        child: Card(
          margin: EdgeInsets.all(40),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: [Container()],
            ),
          ),
        ),
      ),
    );
  }
}
