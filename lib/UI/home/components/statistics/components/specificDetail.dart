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
  String chosenValue;

  Widget dropdownEmployeeList(DataBloc bloc) => Container(
        child: StreamBuilder(
            stream: bloc.showAllEmployees(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return Text('Getting employees...');
              List<Employee> _employees = snapshot.data;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 10),
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
                      ? (String value) => setState(() => chosenValue = value)
                      : null,
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue[900],
                  ),
                  elevation: 15,
                  dropdownColor: Colors.grey[100],
                  hint: Text('Select Employee by Name here'),
                  disabledHint: Text('Add Employees to begin'),
                  value: chosenValue,
                ),
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    DataBloc _bloc = context.watch<DataBloc>();
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 15,
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
                onPressed: (chosenValue == 'safesync-iot-sanitize')
                    ? null
                    : () {
                        if (chosenValue == null) return null;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeEvents(chosenValue)));
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
