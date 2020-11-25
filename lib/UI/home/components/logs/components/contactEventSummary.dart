import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_sync/Backend/bloc/databaseBloc.dart';

import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

import 'package:safe_sync/UI/Home/components/attendance/attendance.dart';

/// Specific Class used only in this UI component to summarise contacts by employees.
class EmployeeContactData {
  Employee employee;
  int contacts;

  EmployeeContactData(
    this.employee, {
    this.contacts = 0,
  });
}

class EmployeeSubInformation extends StatelessWidget {
  const EmployeeSubInformation({
    Key key,
    @required this.summarizedDataItem,
  }) : super(key: key);

  final EmployeeContactData summarizedDataItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: importantConstants.cardSubText(
                    'ID: ${summarizedDataItem.employee.employeeID}',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: importantConstants.cardSubText(
                    'Device ID: ${summarizedDataItem.employee.deviceID}',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              'Contact: ${summarizedDataItem.employee.phoneNo}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Specific Helper Function used only in this UI component to summarise contacts by employees.
class ContactEventSummary extends StatelessWidget {
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

  /// Simple helper function to count [queryEventType] contacts for each employee
  /// from List<Event> [events] using DataBloc [bloc]'s getEmployeesFromEvent method
  Future<List<EmployeeContactData>> _getSummarisedData(
      List<Event> events, DataBloc bloc, String queryEventType) async {
    Map<String, EmployeeContactData> outputSummarisedDataMap = {};
    for (Event event in events) {
      // If not an event of queryEventType, it won't be included anyway
      if (event.eventType != queryEventType) continue;

      if (outputSummarisedDataMap.containsKey(event.deviceIDA))
        ++outputSummarisedDataMap[event.deviceIDA].contacts;
      else {
        Employee employee = (await bloc.getEmployeesFromEvent(event))['A'];
        outputSummarisedDataMap[event.deviceIDA] = EmployeeContactData(
          employee,
          contacts: 1,
        );
      }
    }
    return outputSummarisedDataMap.values.toList();
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

        List<EmployeeContactData> summarizedData = futureSnapshot.data;
        if (summarizedData.length == 0) {
          String _criteria = (queryEventType.compareTo('contact') == 0)
              ? 'Short'
              : 'Dangerous';
          return Center(
            heightFactor: 5,
            widthFactor: 5,
            child: Text(
              "Nobody had $_criteria Contacts yet!",
              style: TextStyle(
                color: importantConstants.textLightColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: summarizedData.length,
            itemBuilder: (context, index) {
              int numberContacts = summarizedData[index].contacts;
              return Card(
                borderOnForeground: true,
                shadowColor: _iconChooser(queryEventType).color,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: _iconChooser(queryEventType).color),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ListTile(
                  leading: _iconChooser(queryEventType),
                  title: Text(
                    summarizedData[index].employee.name,
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: EmployeeSubInformation(
                    summarizedDataItem: summarizedData[index],
                  ),
                  subtitle: Text(
                    '$numberContacts times',
                    style: TextStyle(fontSize: 13),
                  ),
                  focusColor: _iconChooser(queryEventType).color,
                  onTap: (summarizedData[index].employee != null)
                      ? () => Navigator.pushNamed(
                            context,
                            '/employeeManage/add',
                            arguments: summarizedData[index].employee,
                          )
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
        title: importantConstants.appBarText('Summary of Contacts'),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: importantConstants.withBackgroundPlasma(
          child: Card(
            margin: EdgeInsets.all(40),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 8,
            child: StreamBuilder(
              stream: _bloc.showAllEvents(),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
      ),
    );
  }
}
