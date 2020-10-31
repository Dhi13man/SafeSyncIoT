import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/sharedDatabase.dart';
import 'package:safe_sync/Backend/constants.dart';

class EmployeeAdd extends StatelessWidget {
  const EmployeeAdd({Key key, Employee employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _dimensions = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Employee'),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: _dimensions.width,
        height: double.infinity,
        decoration: importantConstants.bgGradDecoration,
        child: Column(children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                margin: EdgeInsets.all(importantConstants.defaultPadding),
                width: _dimensions.width,
                decoration: BoxDecoration(
                  color: importantConstants.textLightestColor,
                  border: Border.all(
                      color: Colors.black, style: BorderStyle.solid, width: 5),
                ),
                padding: EdgeInsets.all(10),
                child: EmployeeForm(),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class EmployeeForm extends StatefulWidget {
  EmployeeForm({Key key}) : super(key: key);

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final Map<String, TextEditingController> _controlMap = {
    'id': TextEditingController(),
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'device': TextEditingController()
  };

  void _insertToDatabase(BuildContext context) {
    if (_controlMap['id'].text.isEmpty) return;

    String id = _controlMap['id'].text, name, device, phone;

    if (_controlMap['name'].text.isNotEmpty) {
      name = _controlMap['name'].text;
    }
    if (_controlMap['device'].text.isNotEmpty) {
      device = _controlMap['device'].text;
    }
    if (_controlMap['phone'].text.isNotEmpty) {
      phone = _controlMap['phone'].text;
    }

    BlocProvider.of<DataBloc>(context).createEmployee(Employee(
        employeeID: id,
        name: name,
        deviceID: device,
        phoneNo: int.parse(phone)));
    BlocProvider.of<DataBloc>(context).resetAttendance(id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Employee Details',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            TextField(
              controller: _controlMap['id'],
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Employee ID',
              ),
            ),
            TextField(
              controller: _controlMap['name'],
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Employee Name',
              ),
            ),
            TextField(
              controller: _controlMap['phone'],
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Phone No.',
              ),
            ),
            TextField(
              controller: _controlMap['device'],
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Provided Device ID',
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 40),
                width: _width,
                child: Expanded(
                  child: CupertinoButton(
                    color: importantConstants.bgGradMid,
                    child: Text('Add Employee',
                        style: TextStyle(
                          fontSize: 10,
                          color: importantConstants.textLightestColor,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {
                      _insertToDatabase(context);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
