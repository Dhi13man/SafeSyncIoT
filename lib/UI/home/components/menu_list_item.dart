import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/Backend/providers/homepagetabprovider.dart';

class ListItem extends StatelessWidget {
  final String itemText;
  final int tab;
  final tabColor;

  final List<IconData> _tabIcon = [
    Icons.book,
    Icons.person_add_alt,
    Icons.format_list_numbered_sharp
  ];

  ListItem({this.itemText, this.tab, this.tabColor});

  @override
  Widget build(BuildContext context) {
    double _infoSize = (importantConstants.onMobileScreen) ? 11 : 15;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.25),
      child: GestureDetector(
        onTap: () => context.read<HomeTabState>().openTab(tab),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.elliptical(30, 20)),
          child: Container(
            height: 40,
            width: double.infinity,
            alignment: Alignment.center,
            color: tabColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  _tabIcon[tab],
                  size: _infoSize,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                ),
                Text(
                  itemText,
                  style: TextStyle(
                    fontSize: _infoSize - 2,
                    fontWeight: FontWeight.bold,
                    color: importantConstants.textColor,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
