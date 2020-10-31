import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String _text;

  const InfoText(this._text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 20.0),
      child: Text(
        this._text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
