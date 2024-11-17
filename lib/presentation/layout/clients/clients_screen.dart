import 'package:flutter/material.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/functions/show_bottom_sheet.dart';
import 'package:invman/presentation/layout/profile/profile_bottom_sheet.dart';
import 'package:invman/presentation/responsive/responsive.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'add_new_client.dart';
import 'clients_table.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {

  final DataGridController _dataGridController = DataGridController();
  late List<Employee> employees ;
  late EmployeeDataSource employeeDataSource;
  bool selected = false;

  List<Employee> getEmployees() {
    return List.generate(20, (index) {
      index = index+1;
      return Employee(100+index, 'Person name $index', index+index, 10*index, 5*index);});
  }
  @override
  void initState() {
    super.initState();
    employees = getEmployees();
    employeeDataSource = EmployeeDataSource(employees: employees);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: (){navigateTo(context, const ClientMangmentScreen());},
                textColor: Colors.white,
                color: Colors.green,
                child: Row(
                  children: const [
                    Icon(Icons.add_circle,),
                    SizedBox(width: 5,),
                    Text('add new'),
                  ],
                ),
              ),
              const Spacer(),
              MaterialButton(
                onPressed: (){},
                textColor: Colors.white,
                color: selected ? Colors.red :Colors.grey,
                child: Row(
                  children: const [
                    Icon(Icons.remove_circle,),
                    SizedBox(width: 5,),
                    Text('Delete'),
                  ],
                ),
              ),
              const SizedBox(width: 20 ,),
              MaterialButton(
                onPressed: (){},
                textColor: Colors.white,
                color: selected ? Colors.indigo :Colors.grey,
                child: Row(
                  children: const [
                    Icon(Icons.edit,),
                    SizedBox(width: 5,),
                    Text('Edit'),
                  ],
                ),
              ),
              const SizedBox(width: 20,)
            ],
          ),
          Expanded(
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                  headerColor: Colors.indigo.withOpacity(0.4)),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SfDataGrid(
                  controller: _dataGridController,
                  // showSortNumbers: true,
                  allowFiltering: true,
                  showCheckboxColumn: true,
                  onSelectionChanged: (val,cs){
                    print(_dataGridController.selectedRow?.getCells().first.value);
                    selected = _dataGridController.selectedRow?.getCells().first.value == null ? false:true;
                    setState(() {

                    });
                  },
                  selectionMode: SelectionMode.singleDeselect,

                  checkboxColumnSettings: const DataGridCheckboxColumnSettings(
                    showCheckboxOnHeader: false,
                  ),
                  allowSorting: true,
                  footer: const SizedBox(height: 600,),
                  columnWidthMode: ColumnWidthMode.fill,
                  // navigationMode: GridNavigationMode.cel,
                  onCellTap: (val){
                    showBottomSheetWidget(context, const BottomSheetProfile(), height: Responsive.isMobile(context)?0.9 : 0.6);
                    print(val.rowColumnIndex.rowIndex);},
                  shrinkWrapRows: true,
                  // shrinkWrapColumns: true,
                  // verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                  isScrollbarAlwaysShown: true,
                  source: employeeDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'id',
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
                        columnName: 'role',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text('Role'))),
                    GridColumn(
                        columnName: 'deals',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text('Deals'))),
                    GridColumn(
                        columnName: 'payments',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text('Payments'))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
