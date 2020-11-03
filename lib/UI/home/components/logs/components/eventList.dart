import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/UI/Home/components/logs/components/eventCard.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

import 'package:safe_sync/Backend/constants.dart';

class EventList extends StatelessWidget {
  BlocBuilder<DataBloc, ChangeStack> _buildEventList(BuildContext context) {
    DataBloc _bloc = context.bloc<DataBloc>();

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
                        return EventCard(
                            associatedEmployees:
                                _bloc.getEmployeesFromEvent(_events[index]),
                            event: _events[index]);
                      },
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      height: 50,
                      width: MediaQuery.of(_context).size.width,
                      child: CupertinoButton(
                        color: importantConstants.bgGradMid,
                        child: Text('Clear Logs',
                            style: TextStyle(
                              fontSize: 15,
                              color: importantConstants.textLightestColor,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () => _bloc.clearEvents(),
                      )),
                ],
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildEventList(context);
  }
}
