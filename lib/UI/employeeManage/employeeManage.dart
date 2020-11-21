import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:undo/undo.dart';

import 'package:safe_sync/Backend/bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/datafiles/Database.dart';
import 'package:safe_sync/Backend/constants.dart';

import 'package:safe_sync/UI/EmployeeManage/components/employeeCard.dart';
import 'package:safe_sync/UI/safesyncAlerts.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({
    Key key,
    @required String filter,
    @required bool isOrderAscending,
  })  : _filter = filter,
        _isOrderAscending = isOrderAscending,
        super(key: key);

  final String _filter;
  final bool _isOrderAscending;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DataBloc, ChangeStack>(
        builder: (context, ChangeStack cs) {
          return StreamBuilder<List<Employee>>(
            stream: context.watch<DataBloc>().showAllEmployees(
                  orderBy: _filter.toLowerCase(),
                  mode: (_isOrderAscending) ? 'asce' : 'desc',
                ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              final List<Employee> _employees = snapshot.data;
              if (_employees.isEmpty)
                return Container(
                  height: double.infinity,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                    "No Registered Employees",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                );
              else
                return ListView.builder(
                  itemCount: _employees.length,
                  itemBuilder: (context, int index) {
                    return EmployeeCard(
                      _employees[index],
                      key: ValueKey(_employees[index].employeeID),
                    );
                  },
                );
            },
          );
        },
      ),
    );
  }
}

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({Key key}) : super(key: key);

  @override
  _EmployeeManagementState createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement> {
  String _filter = 'Name';
  bool _isOrderAscending = true;

  Widget sortButton(String sortByText) {
    return Container(
      alignment: Alignment.bottomRight,
      height: 20,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: Colors.blue[900],
        onPressed: () {
          setState(
            () {
              _filter = sortByText;
            },
          );
        },
        child: Text(
          sortByText,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage your Employees'),
        centerTitle: true,
        backgroundColor: importantConstants.bgGradBegin,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            tooltip: (_isOrderAscending)
                ? 'Show in Descending Order'
                : 'Show in Ascending Order',
            icon: Icon(
              (_isOrderAscending)
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              setState(
                () {
                  _isOrderAscending = !_isOrderAscending;
                },
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            child: IconButton(
              tooltip: 'Delete All Employees.',
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                safeSyncAlerts.showResetAlert('Employee', context);
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.fromLTRB(0, 10, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text(
                      'Sort by: ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  sortButton('Name'),
                  sortButton('ID'),
                  sortButton('Device'),
                ],
              ),
            ),
            EmployeeList(filter: _filter, isOrderAscending: _isOrderAscending),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        splashColor: Colors.yellow,
        onPressed: () => Navigator.pushNamed(context, '/employeeManage/add'),
        tooltip: 'Add Employee',
      ),
    );
  }
}
