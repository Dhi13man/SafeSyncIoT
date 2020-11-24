import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'package:provider/provider.dart';

class FilterChooser extends ChangeNotifier {
  Map<String, bool> showEventOfType;

  FilterChooser() {
    showEventOfType = {
      'contact': true,
      'danger': true,
      'attendance': true,
      'register': true,
    };
  }

  // CHANGE VISIBILITY OF TYPES AND REBUILT
  void toggleType(String type) {
    showEventOfType[type] = !showEventOfType[type];
    notifyListeners();
  }
}

class FilterButton extends StatelessWidget {
  final String filterTypeText;

  FilterButton(this.filterTypeText, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterChooser watcher = context.watch<FilterChooser>();
    bool isActive = watcher.showEventOfType[filterTypeText.toLowerCase()];
    return Container(
      child: Container(
        alignment: Alignment.bottomRight,
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: 7),
        child: CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: (isActive) ? Colors.blue[900] : Colors.black26,
          onPressed: () => watcher.toggleType(filterTypeText.toLowerCase()),
          child: Text(
            filterTypeText,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }
}

class FilterBar extends StatelessWidget {
  FilterBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Displaying Events: ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            FilterButton('Attendance'),
            FilterButton('Contact'),
            FilterButton('Danger'),
            FilterButton('Register'),
          ],
        ),
      ),
    );
  }
}
