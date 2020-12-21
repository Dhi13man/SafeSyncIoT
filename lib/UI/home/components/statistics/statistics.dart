import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';

import 'package:safe_sync/UI/Home/components/statistics/components/statInfoCard.dart';
import 'package:safe_sync/UI/Home/components/statistics/components/specificDetail.dart';

class EmployeeStatistics extends StatelessWidget {
  final EdgeInsets _margins = EdgeInsets.symmetric(horizontal: 20, vertical: 5);

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return StreamBuilder(
      stream: _bloc.showAllEvents(),
      builder: (_, snapshot) => ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: SpecificDetails(),
            ),
          ),
          Container(
            margin: _margins,
            child: StatisticsInformationCard(
              cardName: 'Percentage of Dangerous Contacts: ',
              type: 'negative',
              informationStream: _bloc.getDangerousContactsPercentage(),
              key: ValueKey('Percentage of Dangerous Contacts: '),
            ),
          ),
          Container(
            margin: _margins,
            child: StatisticsInformationCard(
              cardName: 'Last Sanitization: ',
              type: 'neutral',
              informationStream: _bloc.getSanitizeeNamesBy(
                orderBy: 'last',
                mode: 'desc',
              ),
              key: ValueKey('Last Sanitization: '),
            ),
          ),
          Container(
            margin: _margins,
            child: StatisticsInformationCard(
              cardName: 'Most Sanitized Employee: ',
              type: 'positive',
              informationStream: _bloc.getSanitizeeNamesBy(
                orderBy: 'number',
                mode: 'desc',
              ),
              key: ValueKey('Most Sanitized Employee: '),
            ),
          ),
          Container(
            margin: _margins,
            child: StatisticsInformationCard(
              cardName: 'Least Sanitized Employee: ',
              type: 'negative',
              informationStream: _bloc.getSanitizeeNamesBy(
                orderBy: 'number',
                mode: 'asce',
              ),
              key: ValueKey('Least Sanitized Employee: '),
            ),
          ),
        ],
      ),
    );
  }
}
