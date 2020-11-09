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
  String _chosenValue = 'Select Employee by Name';

  Widget dropdownEmployeeList(DataBloc bloc) => Container(
        child: StreamBuilder(
            stream: bloc.showAllEmployees(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return Text('Getting employees...');
              List<Employee> _employees = snapshot.data;
              return DropdownButton<String>(
                value: _chosenValue,
                items: _employees
                    .map<DropdownMenuItem<String>>((Employee _employee) {
                  return DropdownMenuItem<String>(
                    value: _employee.deviceID,
                    child: Text(_employee.name),
                  );
                }).toList(),
                onChanged: (String value) =>
                    setState(() => _chosenValue = value),
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'See events encountered by Employee: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            dropdownEmployeeList(_bloc),
            CupertinoButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployeeEvents(_chosenValue))),
              color: Colors.black,
              child: Text(
                'See Events encountered',
                style: TextStyle(
                    color: importantConstants.textLightestColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
