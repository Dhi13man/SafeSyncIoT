import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 55),
        color: importantConstants.bgGradBegin,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.layers_clear,
                size: 20,
              ),
            ),
            Text(
              'Reset Events',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        onPressed: () => safeSyncAlerts.showResetAlert('Event', context),
      ),
    );
  }
}

class SummarizeContactsButton extends StatelessWidget {
  const SummarizeContactsButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          height: 50,
          child: CupertinoButton(
            color: importantConstants.bgGradBegin,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.book_sharp,
                    size: 20,
                  ),
                ),
                Text(
                  'Summarize Contacts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/contactEventSummary',
            ),
          ),
        ),
      ],
    );
  }
}

class RealTimeLogs extends StatelessWidget {
  RealTimeLogs({Key key}) : super(key: key);
  final FilterChooser filterstate = FilterChooser();

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return ChangeNotifierProvider.value(
      value: filterstate,
      child: Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 8,
        ),
        child: StreamBuilder<List<Event>>(
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
                FilterBar(),
                EmployeeList(events: _events, bloc: _bloc),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ResetEventsButton(),
                    SummarizeContactsButton(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      builder: (context, child) => child,
    );
  }
}
