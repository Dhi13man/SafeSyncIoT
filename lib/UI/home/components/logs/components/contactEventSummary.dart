import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_sync/Backend/bloc/databaseBloc.dart';

import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

import 'package:safe_sync/UI/Home/components/attendance/attendance.dart';

/// Specific Class used only in this UI component to summarise contacts by employees.
class EmployeeEventData {
  Employee employee;
  int contacts;
  int dangerousContacts;

  EmployeeEventData(
    this.employee, {
    this.contacts = 0,
    this.dangerousContacts = 0,
  });
}

/// Specific Helper Function used only in this UI component to summarise contacts by employees.
class ContactEventSummary extends StatelessWidget {
  Future<List<EmployeeEventData>> _getSummarisedData(
      List<Event> events, DataBloc bloc, String queryEventType) async {
    Map<String, EmployeeEventData> outputSummarisedDataMap = {};
    for (Event event in events) {
      // If not an event of queryEventType, it won't be included anyway
      if (event.eventType != queryEventType) continue;

      if (outputSummarisedDataMap.containsKey(event.deviceIDA)) {
        if (event.eventType == 'contact')
          ++outputSummarisedDataMap[event.deviceIDA].contacts;
        else if (event.eventType == 'danger')
          ++outputSummarisedDataMap[event.deviceIDA].dangerousContacts;
      } else {
        Employee employee = (await bloc.getEmployeesFromEvent(event))['A'];
        if (event.eventType == 'contact')
          outputSummarisedDataMap[event.deviceIDA] = EmployeeEventData(
            employee,
            contacts: 1,
          );
        else if (event.eventType == 'danger')
          outputSummarisedDataMap[event.deviceIDA] = EmployeeEventData(
            employee,
            dangerousContacts: 1,
          );
      }
    }
    return outputSummarisedDataMap.values.toList();
  }

  Icon _iconChooser(String eventType) {
    if (eventType == 'contact')
      return Icon(
        Icons.group,
        color: Colors.amber,
      );
    else
      return Icon(
        Icons.warning_amber_outlined,
        color: Colors.red[900],
      );
  }

  Widget _getSummarisedList(
      List<Event> _events, DataBloc _bloc, String queryEventType) {
    return FutureBuilder(
      future: _getSummarisedData(_events, _bloc, queryEventType),
      builder: (context, AsyncSnapshot futureSnapshot) {
        if (!futureSnapshot.hasData)
          return Center(
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 30,
            ),
          );

        List<EmployeeEventData> summarizedData = futureSnapshot.data;
        return Expanded(
          child: ListView.builder(
            itemCount: summarizedData.length,
            itemBuilder: (context, index) {
              int numberContacts;
              if ((queryEventType.compareTo('contact') == 0)) {
                numberContacts = summarizedData[index].contacts;
              } else {
                numberContacts = summarizedData[index].dangerousContacts;
              }
              return Card(
                shadowColor: _iconChooser(queryEventType).color,
                elevation: 2,
                child: ListTile(
                  leading: _iconChooser(queryEventType),
                  title: Text(
                    summarizedData[index].employee.name,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '$numberContacts times',
                    style: TextStyle(fontSize: 13),
                  ),
                  onTap: (summarizedData[index].employee != null)
                      ? () => Navigator.pushNamed(
                          context, '/employeeManage/add',
                          arguments: summarizedData[index].employee)
                      : null,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return Scaffold(
      appBar: AppBar(
        // Changes based on whether Adding new or editing.
        title: Text('Summary of Contacts'),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: importantConstants.bgGradDecoration,
        child: Card(
          margin: EdgeInsets.all(40),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 8,
          child: FutureBuilder(
            future: _bloc.getAllEvents(),
            builder: (context, snapshot) {
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

              return Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    InfoText('Employees that had Dangerous contacts:'),
                    _getSummarisedList(_events, _bloc, 'danger'),
                    InfoText('Employees that had Short contacts:'),
                    _getSummarisedList(_events, _bloc, 'contact'),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
