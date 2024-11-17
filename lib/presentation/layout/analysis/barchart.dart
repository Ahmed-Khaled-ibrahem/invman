import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class BarChartWidget extends StatelessWidget {
  BarChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        title: ChartTitle(
            text: 'Best Selling',
            alignment: ChartAlignment.near,
            textStyle: Theme.of(context).textTheme.bodyLarge),
        plotAreaBorderWidth: 0,
        tooltipBehavior: TooltipBehavior(
          enable: true,
          borderWidth: 10,
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          zoomMode: ZoomMode.xy,
          enableMouseWheelZooming: true,
          enableSelectionZooming: true,
          enablePinching: true,
        ),
        primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            title: AxisTitle(text: 'Item',)),
        primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Name',),
            // minimum: 0,
            // maximum: 40,
            // interval: 10,
            majorGridLines: const MajorGridLines(width: 0)),
        series: <ColumnSeries<SalesData, String>>[
          ColumnSeries<SalesData, String>(
              // Bind data source
              dataSource: <SalesData>[
                SalesData('red Nike style', 50),
                SalesData('red Nike style2', 40),
                SalesData('red Nike style3', 30),
                SalesData('red Nike style4', 10),
                SalesData('red Nike style5', 5),
                SalesData('red Nike style6', 5),

              ],
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);
  }
}
