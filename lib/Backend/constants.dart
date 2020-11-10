import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImportantConstants {
  Color get textColor => Colors.black;
  Color get textLightColor => Color(0xFF535353);
  Color get bgGradBegin => Colors.purple[900];
  Color get bgGradMid => Colors.blue[900];
  Color get bgGradEnd => Colors.red;
  Color get textLighterColor => Color(0xFFACACAC);
  Color get textLightestColor => Colors.white;
  bool get onSmallerScreen => Platform.isIOS || Platform.isAndroid;
  BoxDecoration get bgGradDecoration => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [bgGradBegin, bgGradMid],
        ),
      );

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

  Widget cardSubText(String _text, {TextStyle style}) {
    style = (style) ??
        TextStyle(
            fontSize: (onSmallerScreen) ? 6 : 9,
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

  EdgeInsetsGeometry get defaultPadding =>
      EdgeInsets.symmetric(vertical: 20, horizontal: 20);
}

final ImportantConstants importantConstants = ImportantConstants();
