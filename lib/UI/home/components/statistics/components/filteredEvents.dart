import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/logs/components/eventCard.dart';

class FilteredEventsView extends StatelessWidget {
  final String filterType, _filter;
  const FilteredEventsView(this._filter,
      {this.filterType = 'deviceID', Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _dimensions = MediaQuery.of(context).size;
    DataBloc _bloc = context.watch<DataBloc>();
    return Scaffold(
      appBar: AppBar(
        // Changes based on whether Adding new or editing.
        title: Text((filterType == 'deviceID')
            ? 'Employee Events Log'
            : 'Showing all contacts'),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradMid,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: _dimensions.width,
        height: _dimensions.height,
        decoration: importantConstants.bgGradDecoration,
        alignment: Alignment.center,
        child: Card(
          margin: EdgeInsets.all(40),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(20),
            child: StreamBuilder(
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
                return ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: (context, index) => FutureBuilder(
                    future: _bloc.getEmployeesFromEvent(_events[index]),
                    builder: (_context, snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicator.adaptive();
                      return EventCard(
                        _events[index],
                        employees: snapshot.data,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
