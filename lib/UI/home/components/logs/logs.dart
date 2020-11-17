import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/logs/components/eventCard.dart';
import 'package:safe_sync/UI/safesyncAlerts.dart';

class RealTimeLogs extends StatelessWidget {
  BlocBuilder<DataBloc, ChangeStack> _buildEventList(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return BlocBuilder<DataBloc, ChangeStack>(
      builder: (_context, cs) {
        return StreamBuilder<List<Event>>(
            stream: _bloc.showAllEvents(),
            builder: (_context, snapshot) {
              if (!snapshot.hasData)
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );

              // No Events Found
              List<Event> _events = snapshot.data;
              if (_events.isEmpty)
                return Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                    "No Events have occured yet.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _events.length,
                      itemBuilder: (BuildContext _context, int index) {
                        return FutureBuilder(
                          future: _bloc.getEmployeesFromEvent(_events[index]),
                          builder: (_context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData)
                              return Center(
                                child: importantConstants
                                    .cardSubText('...Loading...'),
                              );
                            Map<String, Employee> _eventEmployees =
                                snapshot.data;
                            return EventCard(
                              _events[index],
                              employees: _eventEmployees,
                              key: ValueKey(_events[index].key),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      height: 50,
                      margin: EdgeInsets.all(5),
                      child: CupertinoButton(
                        color: importantConstants.bgGradMid,
                        child: Text('Clear Logs',
                            style: TextStyle(
                              fontSize: 15,
                              color: importantConstants.textLightestColor,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () =>
                            safeSyncAlerts.showResetAlert('Event', context),
                      )),
                ],
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(
        top: 20,
        bottom: 8,
      ),
      child: _buildEventList(context),
    );
  }
}
