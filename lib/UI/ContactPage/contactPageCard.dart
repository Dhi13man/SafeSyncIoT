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
        title: Text(e),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(githubURL);
      },
      behavior: HitTestBehavior.translucent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Card(
          elevation: 20,
          shadowColor: Colors.purple,
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
      ),
    );
  }
}
