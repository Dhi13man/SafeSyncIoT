import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';

import 'package:safe_sync/UI/Home/components/statistics/components/infoCard.dart';
import 'package:safe_sync/UI/Home/components/statistics/components/specificDetail.dart';

class EmployeeStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return ListView(
      children: [
        Container(margin: EdgeInsets.all(10), child: SpecificDetails()),
        Container(
          margin: EdgeInsets.all(10),
          child: InformationCard(
            cardName: 'Last Sanitization: ',
            type: 'neutral',
            informationStream: _bloc
                .getSanitizeeNamesBy(orderBy: 'last', mode: 'desc')
                .asStream(),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: InformationCard(
            cardName: 'Most Sanitized Employee: ',
            type: 'positive',
            informationStream: _bloc
                .getSanitizeeNamesBy(orderBy: 'number', mode: 'desc')
                .asStream(),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: InformationCard(
            cardName: 'Least Sanitized Employee: ',
            type: 'negative',
            informationStream: _bloc
                .getSanitizeeNamesBy(orderBy: 'number', mode: 'asce')
                .asStream(),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: InformationCard(
            cardName: 'Dangerous Contact Percentage: ',
            type: 'negative',
            informationStream:
                _bloc.getDangerousContactsPercentage().asStream(),
          ),
        ),
      ],
    );
  }
}
