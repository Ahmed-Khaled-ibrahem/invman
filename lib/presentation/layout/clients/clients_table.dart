import 'package:flutter/material.dart';
import 'package:invman/functions/show_bottom_sheet.dart';
import 'package:invman/presentation/layout/profile/profile_bottom_sheet.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';


class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'id', value: e.id),
          DataGridCell<String>(columnName: 'name', value: e.name),
          DataGridCell<int>(columnName: 'role', value: e.role),
          DataGridCell<int>(columnName: 'deals', value: e.deals),
          DataGridCell<int>(columnName: 'payments', value: e.payments),
        ]))
        .toList();
  }

  List<DataGridRow>  _employees = [];

  @override
  List<DataGridRow> get rows =>  _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16.0),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.role, this.deals, this.payments);
  final int id;
  final String name;
  final int role;
  final int deals;
  final int payments;
}