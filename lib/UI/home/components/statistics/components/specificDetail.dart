import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/Home/components/statistics/components/employeeEvents.dart';

class SpecificDetails extends StatefulWidget {
  SpecificDetails({Key key}) : super(key: key);

  @override
  _SpecificDetailsState createState() => _SpecificDetailsState();
}

class _SpecificDetailsState extends State<SpecificDetails> {
  String _chosenValue;

  Widget dropdownEmployeeList(DataBloc bloc) => Container(
        child: StreamBuilder(
            stream: bloc.showAllEmployees(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return Text('Getting employees...');
              List<Employee> _employees = snapshot.data;
              return DropdownButton<String>(
                items: _employees
                    .map<DropdownMenuItem<String>>((Employee _employee) {
                  return DropdownMenuItem<String>(
                    value: _employee.deviceID,
                    child: Container(
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              bottom:
                                  BorderSide(color: Colors.white, width: 1))),
                      child: Text(
                        _employee.name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String value) =>
                    setState(() => _chosenValue = value),
                icon: Icon(
                  Icons.person,
                  color: Colors.blue[900],
                ),
                elevation: 15,
                dropdownColor: Colors.blue[900],
                hint: Text((_employees.isNotEmpty)
                    ? 'Select Employee by Name here'
                    : 'Add Employees to begin'),
                value: _chosenValue,
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 13,
      shadowColor: Colors.purple[900],
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(
          children: [
            Text(
              'See events encountered by Employee: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            dropdownEmployeeList(_bloc),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: CupertinoButton(
                onPressed: (_chosenValue == 'safesync-iot-sanitize')
                    ? null
                    : () {
                        if (_chosenValue == null) return null;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeEvents(_chosenValue)));
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
