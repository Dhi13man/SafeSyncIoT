import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/Home/components/statistics/components/filteredEvents.dart';

class SpecificDetails extends StatefulWidget {
  SpecificDetails({Key key}) : super(key: key);

  @override
  _SpecificDetailsState createState() => _SpecificDetailsState();
}

class _SpecificDetailsState extends State<SpecificDetails> {
  String _employeeDeviceID;

  Widget dropdownEmployeeList(DataBloc bloc) => Container(
        child: StreamBuilder(
            stream: bloc.showAllEmployees(),
            builder: (_, snapshot) {
              if (!snapshot.hasData)
                return Text(
                  'Getting employees...',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                );
              List<Employee> _employees = snapshot.data;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.grey[100],
                  child: DropdownButton<String>(
                    items: _employees
                        .map<DropdownMenuItem<String>>((Employee _employee) {
                      return DropdownMenuItem<String>(
                        value: _employee.deviceID,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _employee.name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (_employees.isNotEmpty)
                        ? (String value) =>
                            setState(() => _employeeDeviceID = value)
                        : null,
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue[900],
                    ),
                    elevation: 15,
                    dropdownColor: Colors.grey[100],
                    hint: Text('Select Employee by Name here'),
                    disabledHint: Text('Add Employees to begin'),
                    value: _employeeDeviceID,
                  ),
                ),
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return Card(
      shape: BeveledRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      elevation: 10,
      shadowColor: Colors.black,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(
          children: [
            Text(
              'Check events encountered by Employee: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            dropdownEmployeeList(_bloc),
            // BUTTON TAKING TO EMPLOYEE EVENTS LOG PAGE.
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: CupertinoButton(
                onPressed: (_employeeDeviceID == 'safesync-iot-sanitize')
                    ? null
                    : () {
                        if (_employeeDeviceID == null) return null;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilteredEventsView(
                              _employeeDeviceID,
                              filterType: 'deviceID',
                            ),
                          ),
                        );
                      },
                color: Colors.black,
                child: Text(
                  'See Events encountered',
                  style: TextStyle(
                      fontSize: 15,
                      color: importantConstants.textLightestColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
