import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:safe_sync/Backend/constants.dart';

class ContactCard extends StatelessWidget {
  final String _name, githubURL, emailID;

  ContactCard(this._name, {this.githubURL, this.emailID, Key key})
      : super(key: key);

  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      AlertDialog(
        title: Text('Error: $e Provide Valid URL.'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      shadowColor: Colors.purple,
      margin: EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: RawMaterialButton(
        onPressed: () => _launchURL(githubURL),
        splashColor: Colors.black,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$_name',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                      icon: Icon(Icons.email_sharp),
                      onPressed: () => _launchURL('mailto:$emailID'),
                    ),
                  ),
                  importantConstants.cardText(githubURL),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
