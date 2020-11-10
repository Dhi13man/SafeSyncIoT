import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/Home/components/logs/components/eventCard.dart';

class EmployeeEvents extends StatelessWidget {
  final String _employeeDeviceID;
  const EmployeeEvents(this._employeeDeviceID, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _dimensions = MediaQuery.of(context).size;
    DataBloc _bloc = context.watch<DataBloc>();
    return Scaffold(
      appBar: AppBar(
        title: // Changes based on whether Adding new or editing.
            Text('Employee Events Log'),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Dialog(
            elevation: 8,
            child: Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder(
                stream: _bloc.showEventsForDeviceID(_employeeDeviceID),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  List<Event> _events = snapshot.data;
                  if (_events.isEmpty)
                    return Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text(
                        "No Events have occured yet for chosen Employee.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    );
                  return ListView.builder(
                    itemCount: _events.length,
                    itemBuilder: (context, index) => FutureBuilder(
                      future: _bloc.getEmployeesFromEvent(_events[index]),
                      builder: (_context, snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator.adaptive();
                        return EventCard(snapshot.data);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
