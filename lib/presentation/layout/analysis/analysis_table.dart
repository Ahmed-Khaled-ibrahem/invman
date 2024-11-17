import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class AnalysisDataSource extends DataGridSource {
  AnalysisDataSource({required List<Employee> employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'id', value: e.id),
          DataGridCell<String>(columnName: 'name', value: e.name),
          DataGridCell<int>(columnName: 'QTY', value: e.qty),
          DataGridCell<double>(columnName: 'Revenue', value: e.revenue),
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
  Employee(this.id, this.name, this.qty, this.revenue);
  final int id;
  final String name;
  final int qty;
  final double revenue;
}