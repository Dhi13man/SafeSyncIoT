import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final String _name, githubURL, emailID;

  ContactCard(this._name, {this.githubURL, this.emailID});

  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      AlertDialog(
        title: e,
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
      child: Card(
        child: Padding(
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
                  Text(githubURL,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: CupertinoColors.darkBackgroundGray)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}