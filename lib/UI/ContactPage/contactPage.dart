import 'package:flutter/material.dart';
import 'package:safe_sync/UI/ContactPage/contactPageCard.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact the devs!'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        children: <Widget>[
          ContactCard('Dhiman Seal',
              githubURL: 'https://github.com/Dhi13man',
              emailID: 'mailto:furyx.ds@gmail.com'),
          ContactCard('Kaustav Moni Malakar',
              githubURL: '', emailID: 'mailto:'),
          ContactCard('Prantik Sarkar',
              githubURL: '', emailID: 'mailto:prantiks44@gmail.com'),
          ContactCard('Sabuj Saikia',
              githubURL: '', emailID: 'mailto:sabuj.saikia2007@gmail.com'),
        ],
      ),
    );
  }
}
