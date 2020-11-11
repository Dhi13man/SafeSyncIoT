import 'package:flutter/material.dart';
import 'package:safe_sync/Backend/constants.dart';

class InformationCard extends StatelessWidget {
  final String type, cardName; // Type: positive, neutral, negative
  final Future informationStream;
  final Map<String, Color> _cardShadowColor = {
    'positive': Colors.green[900],
    'neutral': importantConstants.bgGradBegin,
    'negative': Colors.red[900]
  };
  final Map<String, IconData> _cardIcon = {
    'positive': Icons.clean_hands,
    'neutral': Icons.adjust,
    'negative': Icons.sick,
  };
  InformationCard(
      {this.cardName, this.type = 'neutral', this.informationStream, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: _cardShadowColor[type]),
          borderRadius: BorderRadius.circular(25)),
      elevation: 5,
      shadowColor: _cardShadowColor[type],
      borderOnForeground: true,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                  right: 15,
                ),
                child: Icon(
                  _cardIcon[type],
                  color: _cardShadowColor[type],
                ),
              ),
            ),
            FutureBuilder(
              future: informationStream,
              builder: (context, AsyncSnapshot snapshot) {
                String _output;
                if (!snapshot.hasData)
                  _output = 'loading...';
                else
                  _output = snapshot.data;
                return importantConstants.cardText('$cardName $_output');
              },
            ),
          ],
        ),
      ),
    );
  }
}
