import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_sync/Backend/Bloc/databaseBloc.dart';
import 'package:safe_sync/Backend/Database/sharedDatabase.dart';
import 'package:safe_sync/Backend/constants.dart';
import 'package:safe_sync/UI/EmployeeManage/components/employeeCard.dart';
import 'package:undo/undo.dart';

class EmployeeManagement extends StatelessWidget {
  const EmployeeManagement({Key key}) : super(key: key);
  DataBloc bloc(BuildContext context) => BlocProvider.of<DataBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, ChangeStack>(
      builder: (context, cs) => Scaffold(
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
              tooltip: 'Delete All Employees.',
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                BlocProvider.of<DataBloc>(context).clear();
              },
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: StreamBuilder<List<Employee>>(
              stream: bloc(context).showAllEmployees(),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  );
                else
                  return ListView.builder(
                    itemCount: _employees.length,
                    itemBuilder: (context, index) {
                      return EmployeeCard(_employees[index]);
                    },
                  );
              },
            )),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          splashColor: Colors.yellow,
          onPressed: () =>
              {Navigator.pushNamed(context, '/employeeManage/add')},
          tooltip: 'Add Employee',
        ),
      ),
    );
  }
}
