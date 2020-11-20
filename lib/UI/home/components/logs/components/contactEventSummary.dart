import 'package:flutter/material.dart';

class ContactEventSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Changes based on whether Adding new or editing.
        title: Text('Summary of Contacts'),
        centerTitle: true,
      ),
    );
  }
}
