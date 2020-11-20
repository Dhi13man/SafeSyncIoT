import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/logs/components/filterBar.dart';
import 'package:safe_sync/UI/Home/components/logs/components/eventCard.dart';
import 'package:safe_sync/UI/safesyncAlerts.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({
    Key key,
    @required List<Event> events,
    @required DataBloc bloc,
  })  : _events = events,
        _bloc = bloc,
        super(key: key);

  final List<Event> _events;
  final DataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _events.length,
        itemBuilder: (BuildContext _context, int index) {
          // If not showEvent of this type, don't show event
          if (!_context
              .watch<FilterChooser>()
              .showEventOfType[_events[index].eventType]) return Container();
          // Else show
          return FutureBuilder(
            future: _bloc.getEmployeesFromEvent(_events[index]),
            builder: (_context, AsyncSnapshot snapshot) {
              Map<String, Employee> _eventEmployees = snapshot.data;
              // Added animation during loading
              return AnimatedCrossFade(
                firstChild: Center(
                  child: importantConstants.cardSubText('...Loading...'),
                ),
                secondChild: (snapshot.hasData)
                    ? EventCard(
                        _events[index],
                        employees: _eventEmployees,
                        key: ValueKey(_events[index].key),
                      )
                    : Container(),
                duration: Duration(milliseconds: 250),
                crossFadeState: (!snapshot.hasData)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              );
            },
          );
        },
      ),
    );
  }
}

class ResetEventsButton extends StatelessWidget {
  const ResetEventsButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 50,
      margin: EdgeInsets.all(5),
      child: CupertinoButton(
        color: importantConstants.bgGradMid,
        child: Text(
          'Clear Logs',
          style: TextStyle(
            fontSize: 15,
            color: importantConstants.textLightestColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => safeSyncAlerts.showResetAlert('Event', context),
      ),
    );
  }
}

class RealTimeLogs extends StatelessWidget {
  RealTimeLogs({Key key}) : super(key: key);
  final FilterChooser showEventState = FilterChooser();

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(
        top: 20,
        bottom: 8,
      ),
      child: BlocBuilder<DataBloc, ChangeStack>(
        cubit: _bloc,
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

              return ChangeNotifierProvider<FilterChooser>.value(
                value: showEventState,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(Icons.cloud_download_outlined),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                'contactSummary',
                              ),
                            ),
                          ),
                        ),
                        FilterBar(),
                      ],
                    ),
                    EmployeeList(events: _events, bloc: _bloc),
                    ResetEventsButton(),
                  ],
                ),
                builder: (context, child) => child,
              );
            },
          );
        },
      ),
    );
  }
}
