import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:safe_sync/UI/safesyncAlerts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:safe_sync/Backend/constants.dart';

class ContactCard extends StatelessWidget {
  final String _name, githubURL, emailID;

  ContactCard(this._name, {this.githubURL, this.emailID, Key key})
      : super(key: key);

  void _launchURL(BuildContext context, String url) async {
    try {
      if (url == '') throw 'Empty URL';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      safeSyncAlerts.showErrorAlert(context, '$e. Valid URL was not provided.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      shadowColor: importantConstants.bgGradMid,
      margin: EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: RawMaterialButton(
        onPressed:
            (githubURL != null) ? () => _launchURL(context, githubURL) : null,
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
                      onPressed: (emailID != null)
                          ? () => _launchURL(context, 'mailto:$emailID')
                          : null,
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
