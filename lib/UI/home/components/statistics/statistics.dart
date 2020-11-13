import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';

import 'package:safe_sync/UI/Home/components/statistics/components/infoCard.dart';
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
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: SpecificDetails(),
                ),
                Container(
                  margin: _margins,
                  child: InformationCard(
                    cardName: 'Dangerous Contact Percentage: ',
                    type: 'negative',
                    informationStream: _bloc.getDangerousContactsPercentage(),
                    key: ObjectKey('Dangerous Contact Percentage: '),
                  ),
                ),
                Container(
                  margin: _margins,
                  child: InformationCard(
                    cardName: 'Last Sanitization: ',
                    type: 'neutral',
                    informationStream: _bloc.getSanitizeeNamesBy(
                      orderBy: 'last',
                      mode: 'desc',
                    ),
                    key: ObjectKey('Last Sanitization: '),
                  ),
                ),
                Container(
                  margin: _margins,
                  child: InformationCard(
                    cardName: 'Most Sanitized Employee: ',
                    type: 'positive',
                    informationStream: _bloc.getSanitizeeNamesBy(
                      orderBy: 'number',
                      mode: 'desc',
                    ),
                    key: ObjectKey('Most Sanitized Employee: '),
                  ),
                ),
                Container(
                  margin: _margins,
                  child: InformationCard(
                    cardName: 'Least Sanitized Employee: ',
                    type: 'negative',
                    informationStream: _bloc.getSanitizeeNamesBy(
                      orderBy: 'number',
                      mode: 'asce',
                    ),
                    key: ObjectKey('Least Sanitized Employee: '),
                  ),
                ),
              ],
            ));
  }
}
