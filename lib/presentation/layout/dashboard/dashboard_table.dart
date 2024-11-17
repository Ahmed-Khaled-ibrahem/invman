import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Widget dashboardTable(){
  
  return BlocBuilder<AppCubit, AppStates>(
  builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);

    EmployeeDataSource employeeDataSource = EmployeeDataSource(
        employees: cubit.realmServices.realm.all<Product>().toList()
    );

    return SfDataGrid(
    // allowFiltering: true,
    footer: const SizedBox(height: 600,),
    columnWidthMode: ColumnWidthMode.fill,
    // navigationMode: GridNavigationMode.cel,
    onCellTap: (val){print(val.rowColumnIndex.rowIndex);},
    shrinkWrapRows: true,
    // shrinkWrapColumns: true,
    verticalScrollPhysics: const NeverScrollableScrollPhysics(),
    isScrollbarAlwaysShown: true,
    source: employeeDataSource,
    columns: <GridColumn>[
      GridColumn(
          columnName: 'id',
          minimumWidth: 200,
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'ID',
              ))),
      GridColumn(
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: const Text('Name'))),
      GridColumn(
          columnName: 'stock',
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: const Text('Stock'))),
      GridColumn(
          columnName: 'in_price',
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: const Text('In cost'))),
      GridColumn(
          columnName: 'out_price',
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: const Text('Out price'))),
    ],
  );
  },
);
}


class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Product> employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(
        cells: [
      DataGridCell<String>(columnName: 'id', value: e.id.toString()),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<double>(columnName: 'stock', value: e.totalStock),
      DataGridCell<double>(columnName: 'in_price', value: e.price),
      DataGridCell<double>(columnName: 'out_price', value: e.cost),
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

