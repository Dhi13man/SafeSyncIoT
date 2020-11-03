import 'package:flutter/material.dart';

import 'package:safe_sync/UI/Home/components/logs/components/eventList.dart';

class RealTimeLogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: EventList(),
    );
  }
}
