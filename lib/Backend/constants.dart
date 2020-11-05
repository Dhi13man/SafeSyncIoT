import 'dart:io';
import 'package:flutter/material.dart';

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

  final double defaultPadding = 20.0;
}

final ImportantConstants importantConstants = ImportantConstants();
