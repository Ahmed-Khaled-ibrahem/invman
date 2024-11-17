import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/functions/show_bottom_sheet.dart';
import 'package:invman/model/realm_models/transaction/transaction.dart';
import 'package:invman/presentation/layout/transactions/report_screen.dart';
import 'package:invman/presentation/layout/transactions/reverse_screen.dart';
import 'package:invman/presentation/layout/transactions/transaction_info.dart';
import 'package:invman/presentation/layout/transactions/transactions_table.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  final DataGridController _dataGridController = DataGridController();
  late EmployeeDataSource employeeDataSource;
  bool selected = false;
  TextEditingController startDateController = TextEditingController(text: '');
  TextEditingController endDateController = TextEditingController(text: '');


  void selectionChanged() async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
  builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);

    // employeeDataSource = EmployeeDataSource(employees: cubit.realmServices.realm.all<TransactionItem>().toList());

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: (){navigateTo(context, const ReportScreen());},
                textColor: Colors.white,
                color: Colors.green,
                child: Row(
                  children: const [
                    Icon(Icons.summarize,),
                    SizedBox(width: 5,),
                    Text('Make a report'),
                  ],
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('From'),
              ),
              MaterialButton(
                onPressed: (){selectionChanged();},
                textColor: Colors.white,
                color:Colors.indigo ,
                child: Row(
                  children: const [
                    Icon(Icons.date_range,),
                    SizedBox(width: 5,),
                    Text('start date'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('To'),
              ),
              MaterialButton(
                onPressed: (){selectionChanged();},
                textColor: Colors.white,
                color:Colors.indigo ,
                child: Row(
                  children: const [
                    Icon(Icons.date_range,),
                    SizedBox(width: 5,),
                    Text('end date'),
                  ],
                ),
              ),

              const Spacer(),

              MaterialButton(
                onPressed: (){
                  if(selected){
                    navigateTo(context, ReverseScreen());
                  }
                },
                textColor: Colors.white,
                color: selected ? Colors.deepOrange :Colors.grey,
                child: Row(
                  children: const [
                    Icon(Icons.subdirectory_arrow_left_sharp,),
                    SizedBox(width: 5,),
                    Text('Reverse'),
                  ],
                ),
              ),
              const SizedBox(width: 20,)
            ],
          ),
          Expanded(
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                  headerColor: Colors.green.withOpacity(0.4)),
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
                    // showBottomSheetWidget(context, TransactionsInfo(cubit.realmServices.realm.all<TransactionItem>().toList()[val.rowColumnIndex.rowIndex-1]), height: 0.8);
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
                        columnName: 'date',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text('Date'))),
                    GridColumn(
                        columnName: 'time',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text('Time'))),
                    GridColumn(
                        columnName: 'channel',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text('Channel'))),
                    GridColumn(
                        columnName: 'totalPrice',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text('TotalPrice'))),
                    GridColumn(
                        columnName: 'type',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text('Type'))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }
}
