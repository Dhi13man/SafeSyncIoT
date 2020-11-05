import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

class EmployeeAdd extends StatelessWidget {
  const EmployeeAdd({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _dimensions = MediaQuery.of(context).size;
    Employee employee = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: // Changes based on whether Adding new or editing.
            Text((employee == null) ? 'Add a new Employee' : 'Update Employee'),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: _dimensions.width,
        decoration: importantConstants.bgGradDecoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: EmployeeForm(
            employee: employee,
          ),
        ),
      ),
    );
  }
}

class EmployeeForm extends StatefulWidget {
  final Employee employee;

  EmployeeForm({Key key, this.employee}) : super(key: key);

  @override
  _EmployeeFormState createState() => _EmployeeFormState(employee: employee);
}

class _EmployeeFormState extends State<EmployeeForm> {
  Map<String, TextEditingController> _controlMap;
  bool _editmode;

  final Employee employee;
  _EmployeeFormState({this.employee}) {
    _editmode = employee != null;
    _controlMap = {
      'id': TextEditingController(
        text: (_editmode) ? employee.employeeID : '',
      ),
      'name': TextEditingController(text: (_editmode) ? employee.name : ''),
      'phone': TextEditingController(
          text: (_editmode) ? employee.phoneNo.toString() : ''),
      'device':
          TextEditingController(text: (_editmode) ? employee.deviceID : '')
    };
  }

  void _disposeControllers() {
    _controlMap.forEach((key, value) => value.dispose());
  }

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

    DataBloc _bloc = context.bloc<DataBloc>();

    if (_editmode)
      _bloc.updateEmployee(Employee(
          employeeID: id,
          name: name,
          deviceID: device,
          phoneNo: int.parse(phone)));
    else {
      // ADD NEW EMPLOYEE
      _bloc.createEmployee(Employee(
          employeeID: id,
          name: name,
          deviceID: device,
          phoneNo: int.parse(phone)));

      // ADD EVENT THAT NEW EMPLOYEE WAS ADDED
      DateTime _current = DateTime.now();
      Event _event = Event(
        key: _current.toString() + device,
        eventTime: _current,
        eventType: 'register',
        deviceIDA: device,
      );
      _bloc.createEvent(_event);
      _bloc.resetAttendance(id); // SET ATTENDANCE TO ZERO FOR THIS EMPLOYEE
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
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
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  width: _width,
                  child: CupertinoButton(
                    color: importantConstants.bgGradMid,
                    child: Text(
                        (employee == null) ? 'Add Employee' : 'Update Info',
                        style: TextStyle(
                          fontSize: 15,
                          color: importantConstants.textLightestColor,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {
                      _insertToDatabase(context);
                      _disposeControllers();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
