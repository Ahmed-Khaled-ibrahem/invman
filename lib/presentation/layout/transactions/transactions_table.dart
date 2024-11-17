import 'package:intl/intl.dart';
import 'package:invman/model/const/datetimeFormat.dart';
import 'package:invman/model/realm_models/transaction/transaction.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(
        cells: [
          // DataGridCell<String>(columnName: 'id', value: e.id.toString()),
          // DataGridCell<String>(columnName: 'date', value: DateFormat(DateTimeFormatString.date).format(e.time)),
          // DataGridCell<String>(columnName: 'time', value: DateFormat(DateTimeFormatString.time).format(e.time)),
          // DataGridCell<String>(columnName: 'channel', value: e.channel),
          // DataGridCell<double>(columnName: 'totalPrice', value: e.total),
          // DataGridCell<String>(columnName: 'type', value: e.type),
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

