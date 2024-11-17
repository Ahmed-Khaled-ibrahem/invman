import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/model/const/datetimeFormat.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/model/realm_models/transaction/transaction.dart';
import 'package:invman/presentation/layout/dashboard/line_chart.dart';
import 'package:invman/presentation/layout/dashboard/pie_chart.dart';
import 'package:realm/realm.dart';
import 'dashboard_table.dart';
import 'kpi_tile.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<AppCubit, AppStates>(
  builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);

    double totalSales = 0;
    double stockValue = 0;
    double totalRevenue = 0;
    double profitMargin = 0;
    Map<String, double> lineData = {};
    Map<String, double> pieData = {};


    // cubit.realmServices.realm.all<TransactionItem>().forEach((element) {
    //   totalSales = totalSales +  element.total;
    //
    //   element.items.forEach((id) {
    //     final Product? product = cubit.realmServices.realm.find<Product>(ObjectId.fromHexString(id.split(',')[0].trim()));
    //     totalRevenue = totalRevenue + (product!.price - product.cost);
    //
    //     if(pieData.keys.contains(product.name.toString())){
    //       pieData[product.name.toString()] =
    //           pieData[product.name.toString()]! +
    //               double.parse(id.split(',')[1].trim()) ;
    //     }
    //     else{
    //       pieData.addAll({product.name.toString(): double.parse(id.split(',')[1].trim())});
    //     }
    //   });
    //
    //
    //
    //   String date = DateFormat(DateTimeFormatString.date).format(element.time) ;
    //
    //   if(lineData.keys.contains(date)){
    //     lineData[date] = lineData[date]! + element.total;
    //   }
    //   else{
    //     lineData.addAll({date: element.total});
    //   }
    //
    // });

    cubit.realmServices.realm.all<Product>().forEach((element) {
      stockValue = stockValue +  (element.price * element.totalStock);
    });

    profitMargin = (totalRevenue/totalSales)*100;



    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            children:   [
              kpiTile(screenWidth, 'Total Sales',totalSales.toString(),'\$'),
              kpiTile(screenWidth, 'Stock Value',stockValue.toString(),'\$'),
              kpiTile(screenWidth, 'Revenue',totalRevenue.toString(),'\$'),
              kpiTile(screenWidth, 'Profit Margin',profitMargin.toString(),'%'),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 400,
                  child: PieChartWidget(pieData),
                ),
                SizedBox(
                  width: 600,
                  child: LineChartWidget(lineData),
                ),
              ],
            ),
          ),
          SingleChildScrollView(child: dashboardTable()),
        ],
      ),
    );
  },
);
  }
  
  
}
