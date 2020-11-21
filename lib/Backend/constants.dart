import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:safe_sync/UI/safesyncAlerts.dart';

class ImportantConstants {
  Color get textColor => Colors.black;
  Color get textLightColor => Color(0xFF535353);
  Color get bgGradBegin => Colors.purple[900];
  Color get bgGradMid => Colors.blue[900];
  Color get bgGradEnd => Colors.purple[800];
  Color get textLighterColor => Color(0xFFACACAC);
  Color get textLightestColor => Colors.white;

  /// Whether on small screen
  bool get onMobileScreen => Platform.isIOS || Platform.isAndroid;

  /// Background Theme of app
  BoxDecoration get bgGradDecoration => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.mirror,
          colors: [bgGradBegin, bgGradMid, bgGradEnd],
        ),
      );

  EdgeInsetsGeometry get defaultPadding =>
      EdgeInsets.symmetric(vertical: 20, horizontal: 20);

  /// Launch URL from anywhere in the app
  void launchURL(BuildContext context, String url) async {
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

  /// Where are files being written to?
  Future<String> fileSavePath() async {
    Directory directory;
    if (Platform.isAndroid || Platform.isIOS)
      directory = await getApplicationDocumentsDirectory();
    else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS)
      directory = await getDownloadsDirectory();
    else
      directory = await getTemporaryDirectory();
    return directory.path;
  }

  /// Main scrollable text of Cards used all over the app
  Widget cardText(String _text, {TextStyle style}) {
    style =
        (style) ?? TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
    return Expanded(
      flex: 5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          _text,
          style: style,
        ),
      ),
    );
  }

  /// Scrollable Sub-text of cards used all over the app
  Widget cardSubText(String _text, {TextStyle style}) {
    style = (style) ??
        TextStyle(
            fontSize: (onMobileScreen) ? 6 : 9,
            color: importantConstants.textLighterColor);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        _text,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}

final ImportantConstants importantConstants = ImportantConstants();
