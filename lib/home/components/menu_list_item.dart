import 'package:flutter/material.dart';
import 'package:safe_sync/Backend/constants.dart';

class ListItem extends StatelessWidget {
  final String itemText;
  final int tab;
  final Function selectFunction;
  final tabColor;

  final List<IconData> _tabIcon = [
    Icons.book,
    Icons.person_add_alt,
    Icons.format_list_numbered_sharp
  ];

  ListItem({this.itemText, this.tab, this.selectFunction, this.tabColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.25),
      child: GestureDetector(
        onTap: () => selectFunction(tab),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.elliptical(30, 20)),
          child: Container(
            height: 40,
            color: tabColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                _tabIcon[tab],
                size: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              Text(
                itemText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: importantConstants.textColor,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
