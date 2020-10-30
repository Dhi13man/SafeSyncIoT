import 'package:flutter/material.dart';

class ImportantConstants {
  final Color textColor = Colors.black;
  final Color textLightColor = Color(0xFF535353);
  final Color bgGradBegin = Colors.purple[900];
  final Color bgGradMid = Colors.blue[900];
  final Color bgGradEnd = Colors.red;
  final Color textLighterColor = Color(0xFFACACAC);
  BoxDecoration get bgGradDecoration => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [bgGradBegin, bgGradMid, bgGradEnd],
        ),
      );

  final double defaultPadding = 20.0;
}

final ImportantConstants importantConstants = ImportantConstants();
