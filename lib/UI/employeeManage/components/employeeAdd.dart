import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';

class EmployeeAdd extends StatelessWidget {
  const EmployeeAdd({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _dimensions = MediaQuery.of(context).size;
    // As arguments are passed from other pages through Navigator.pushNamed
    Employee employee = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: // Changes based on whether Adding new or editing.
            Text((employee == null) ? 'Add a new Employee' : 'Update Employee'),
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

    DataBloc _bloc = context.read<DataBloc>();

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
    List<bool> verifyFormData = [
      _editmode, // ID is not editable once set
      false,
      false
    ];
    double _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Dialog(
        elevation: 8,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Text(
                  'Employee Details',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              TextFormField(
                enabled: !_editmode, // ID is not editable in edit mode.
                validator: (value) {
                  if (value.isEmpty) return 'ID is mandatory.';
                  if (value == 'safesync-iot-sanitize')
                    return 'This ID is reserved for Sanitizing Station.';
                  verifyFormData[0] = true;
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                controller: _controlMap['id'],
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Employee ID (Not modifiable once set)',
                ),
              ),
              TextFormField(
                controller: _controlMap['name'],
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Employee Name',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return 'Phone Number is mandatory.';
                  if (value.length > 1) {
                    bool _validPhoneNo = true;
                    try {
                      int _ = int.parse(value.toString());
                    } catch (e) {
                      _validPhoneNo = false;
                    }
                    if (!_validPhoneNo)
                      return 'Contact number can only have digits.';
                  }
                  if (value.length < 10) return 'Phone Number too short.';
                  if (value.length > 13) return 'Phone Number too long.';
                  verifyFormData[1] = true;
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                controller: _controlMap['phone'],
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Phone No.',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return 'Device ID is mandatory.';
                  if (value == 'safesync-iot-sanitize')
                    return 'This ID is reserved for Sanitizing Station.';
                  verifyFormData[2] = true;
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
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
                      if (verifyFormData[0] &&
                          verifyFormData[1] &&
                          verifyFormData[2]) {
                        Future<Employee> _emp = context
                            .read<DataBloc>()
                            .getEmployeeByID(_controlMap['id'].text);
                        _emp.then((value) {
                          if (value == null || _editmode)
                            _insertToDatabase(context);
                          else
                            _controlMap['id'].text += '_ID_TAKEN!';
                        });
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
