import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/logs/components/eventCard.dart';
import 'package:safe_sync/UI/Home/components/logs/components/filterBar.dart';
import 'package:safe_sync/UI/Home/components/logs/logs.dart';

class FilteredEventsList extends StatelessWidget {
  /// Produces a Filtered list of events for Statistics Tab page
  /// [filterType] can be deviceID, employeeA, employeeB or eventType
  /// [filter] is the actual filter ([filter] can also be 'contactDanger' when [filterType] is 'eventType')
  const FilteredEventsList({
    Key key,
    @required String filter,
    @required this.filterType,
  })  : _filter = filter,
        super(key: key);

  final String _filter;
  final String filterType;

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();

    return StreamBuilder(
      stream: _bloc.showEventsForCriteria(_filter, type: filterType),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        List<Event> _events = snapshot.data;
        if (_events.isEmpty)
          return Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              "No such events have occured yet.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          );
        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: FilterBar(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) => FutureBuilder(
                  future: _bloc.getEmployeesFromEvent(_events[index]),
                  builder: (_context, snapshot) {
                    if (!snapshot.hasData)
                      return CircularProgressIndicator.adaptive();

                    // If not showEvent of this type, don't show event
                    if (!_context
                        .watch<FilterChooser>()
                        .showEventOfType[_events[index].eventType])
                      return Container();
                    return EventCard(
                      _events[index],
                      employees: snapshot.data,
                    );
                  },
                ),
              ),
            ),
            // If contacts and dangers are being viewed, give option to summarize.
            (_filter.compareTo('contactDanger') == 0)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SummarizeContactsButton()])
                : Container(),
          ],
        );
      },
    );
  }
}

class FilteredEventsView extends StatelessWidget {
  final String filterType, _filter;
  final FilterChooser showEventState = FilterChooser();
  FilteredEventsView(this._filter, {this.filterType = 'deviceID', Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _dimensions = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // Changes based on whether Adding new or editing.
        title: Text(
          (filterType == 'deviceID')
              ? 'Employee Events Log'
              : 'Showing all contacts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: showEventState,
        child: importantConstants.withBackgroundPlasma(
          child: Container(
            width: _dimensions.width,
            height: _dimensions.height,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Card(
              margin: EdgeInsets.all(40),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              elevation: 8,
              child:
                  FilteredEventsList(filter: _filter, filterType: filterType),
            ),
          ),
        ),
        builder: (context, child) => child,
      ),
    );
  }
}
