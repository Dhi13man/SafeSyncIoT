import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String type;
  const InformationCard({this.type, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(elevation: 10, shadowColor: Colors.amber, child: Text(type)),
    );
  }
}
