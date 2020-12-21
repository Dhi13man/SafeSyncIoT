import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:safe_sync/Backend/providers/homepagetabprovider.dart';

import 'menu_list_item.dart';

class MenuList extends StatelessWidget {
  final Color _selectedColor = Colors.white, _unselectedColor = Colors.white70;

  Color _giveColor(int id, int selectedID) {
    return (id == selectedID) ? _selectedColor : _unselectedColor;
  }

  @override
  Widget build(BuildContext context) {
    HomeTabState homeTabState = Provider.of<HomeTabState>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: ListItem(
            itemText: 'Real-Time Logs',
            tab: 0,
            tabColor: _giveColor(0, homeTabState.homeTabID),
            key: ValueKey(0),
          ),
        ),
        Flexible(
          child: ListItem(
            itemText: 'Attendances',
            tab: 1,
            tabColor: _giveColor(1, homeTabState.homeTabID),
            key: ValueKey(1),
          ),
        ),
        Flexible(
          child: ListItem(
            itemText: 'Statistics',
            tab: 2,
            tabColor: _giveColor(2, homeTabState.homeTabID),
            key: ValueKey(2),
          ),
        )
      ],
    );
  }
}
