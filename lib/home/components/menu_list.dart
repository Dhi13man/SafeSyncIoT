import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'menu_list_item.dart';

class MenuList extends StatelessWidget {
  final Function tabSelect;
  final int selectedTab;
  final Color _selectedColor = Colors.white, _unselectedColor = Colors.white70;

  Color _giveColor(int id) {
    return (id == selectedTab) ? _selectedColor : _unselectedColor;
  }

  MenuList({this.selectedTab, this.tabSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: ListItem(
            itemText: 'Real-Time Logs',
            tab: 0,
            selectFunction: tabSelect,
            tabColor: _giveColor(0),
          ),
        ),
        Flexible(
          child: ListItem(
            itemText: 'Attendance',
            tab: 1,
            selectFunction: tabSelect,
            tabColor: _giveColor(1),
          ),
        ),
        Flexible(
          child: ListItem(
            itemText: 'Statistics',
            tab: 2,
            selectFunction: tabSelect,
            tabColor: _giveColor(2),
          ),
        )
      ],
    );
  }
}
