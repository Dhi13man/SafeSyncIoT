import 'package:flutter/material.dart';
import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/ContactPage/contactPageCard.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _dimensions = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact the Creators!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 3,
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
      ),
      body: Container(
        height: _dimensions.height,
        width: _dimensions.width,
        decoration: importantConstants.bgGradDecoration,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          children: <Widget>[
            ContactCard('Dhiman Seal',
                githubURL: 'https://github.com/Dhi13man',
                emailID: 'furyx.ds@gmail.com'),
            ContactCard('Kaustav Moni Malakar', githubURL: '', emailID: ''),
            ContactCard('Prantik Sarkar',
                githubURL: '', emailID: 'prantiks44@gmail.com'),
            ContactCard('Sabuj Saikia',
                githubURL: '', emailID: 'sabuj.saikia2007@gmail.com'),
          ],
        ),
      ),
    );
  }
}
