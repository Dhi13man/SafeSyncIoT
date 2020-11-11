import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/UI/Home/components/statistics/components/filteredEvents.dart';

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
                    child: SpecificDetails()),
                Container(
                  margin: _margins,
                  child: RawMaterialButton(
                    focusElevation: 15,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilteredEventsView(
                            'contactDanger',
                            filterType: 'eventType',
                          ),
                        ),
                      );
                    },
                    child: InformationCard(
                      cardName: 'Dangerous Contact Percentage: ',
                      type: 'negative',
                      informationStream: _bloc.getDangerousContactsPercentage(),
                    ),
                  ),
                ),
                Container(
                  margin: _margins,
                  child: InformationCard(
                    cardName: 'Last Sanitization: ',
                    type: 'neutral',
                    informationStream: _bloc.getSanitizeeNamesBy(
                        orderBy: 'last', mode: 'desc'),
                  ),
                ),
                Container(
                  margin: _margins,
                  child: InformationCard(
                    cardName: 'Most Sanitized Employee: ',
                    type: 'positive',
                    informationStream: _bloc.getSanitizeeNamesBy(
                        orderBy: 'number', mode: 'desc'),
                  ),
                ),
                Container(
                  margin: _margins,
                  child: InformationCard(
                    cardName: 'Least Sanitized Employee: ',
                    type: 'negative',
                    informationStream: _bloc.getSanitizeeNamesBy(
                        orderBy: 'number', mode: 'asce'),
                  ),
                ),
              ],
            ));
  }
}
