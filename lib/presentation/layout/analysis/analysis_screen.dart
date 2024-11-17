import 'package:flutter/material.dart';
import 'package:invman/presentation/layout/analysis/analysis_table.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'barchart.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {

  late AnalysisDataSource analysisDataSource;
  final DataGridController _dataGridController = DataGridController();
  late List<Employee> employees ;

  void selectionChanged() async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );
  }

  List<Employee> getEmployees() {
    return List.generate(20, (index) {
      index = index+1;
      return Employee(100+index, 'prodcut name', 10, 50);});
  }

  @override
  void initState() {
    super.initState();
    employees = getEmployees();
    analysisDataSource = AnalysisDataSource(employees: employees);
  }

  Widget cardKPI(String title, String value){
    return Card(
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      child: Container(
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
            Colors.blue, Colors.lightBlueAccent
          ])
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(title,style: const TextStyle(color: Colors.indigo,fontWeight: FontWeight.w700),),
              Text(value,style: const TextStyle(fontSize: 30, color: Colors.white),),

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
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
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    cardKPI('Revenue', '20,000\$'),
                    cardKPI('Sales', '50,000\$'),
                    cardKPI('Stock Value', '70,000\$'),
                  ],
                ),
                SizedBox(
                    width: 400,
                    child: BarChartWidget())
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 500,
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      headerColor: Colors.blue.withOpacity(0.4)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SfDataGrid(
                      controller: _dataGridController,
                      // showSortNumbers: true,
                      allowFiltering: true,
                      // showCheckboxColumn: true,
                      // selectionMode: SelectionMode.singleDeselect,

                      // checkboxColumnSettings: const DataGridCheckboxColumnSettings(
                      //   showCheckboxOnHeader: false,
                      // ),
                      allowSorting: true,
                      footer: const SizedBox(height: 20,),
                      columnWidthMode: ColumnWidthMode.fill,
                      // navigationMode: GridNavigationMode.cel,
                      // shrinkWrapRows: true,
                      // shrinkWrapColumns: true,
                      // verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                      isScrollbarAlwaysShown: true,
                      source: analysisDataSource,
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
                            columnName: 'QTY',
                            label: Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerLeft,
                                child: const Text('QTY'))),
                        GridColumn(
                            columnName: 'Revenue',
                            label: Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerLeft,
                                child: const Text('Revenue'))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
