import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String type, cardName; // Type: positive, neutral, negative
  final Map<String, Color> _cardShadowColor = {
    'positive': Colors.green[900],
    'neutral': Colors.amber[700],
    'negative': Colors.red[900]
  };
  InformationCard({this.cardName, this.type = 'neutral', Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 5,
      shadowColor: _cardShadowColor[type],
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Text(cardName),
      ),
    );
  }
}
