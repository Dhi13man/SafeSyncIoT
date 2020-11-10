import 'package:flutter/material.dart';

import 'package:safe_sync/UI/Home/components/statistics/components/infoCard.dart';
import 'package:safe_sync/UI/Home/components/statistics/components/specificDetail.dart';

class EmployeeStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(margin: EdgeInsets.all(10), child: SpecificDetails()),
        Container(
          margin: EdgeInsets.all(10),
          child: InformationCard(
            cardName: 'Most Sanitized Employee: ',
            type: 'positive',
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: InformationCard(
            cardName: 'Last Sanitization: ',
            type: 'neutral',
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: InformationCard(
            cardName: 'Least Sanitized Employee: ',
            type: 'negative',
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: InformationCard(
            cardName: 'Employee with most Contacts: ',
            type: 'negative',
          ),
        ),
      ],
    );
  }
}
