import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class LineChartWidget extends StatelessWidget {
  LineChartWidget(this.lineData, {Key? key}) : super(key: key);

  Map<String, double> lineData ;



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
  builder: (context, state) {

    return SfCartesianChart(
        title: ChartTitle(
            text: 'Daily Sales',
            alignment: ChartAlignment.near,
            textStyle: Theme.of(context).textTheme.bodyLarge),
        plotAreaBorderWidth: 0,
        tooltipBehavior: TooltipBehavior(
          enable: true,
          borderWidth: 5,
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
            title: AxisTitle(text: 'Day',)),
        primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Dollar',),
            minimum: 0,
            // interval: 10,
            majorGridLines: const MajorGridLines(width: 0)),
        series: <ColumnSeries<SalesData, String>>[
          ColumnSeries<SalesData, String>(
              // Bind data source
              dataSource: List.generate(lineData.length, (index) =>
                  SalesData(lineData.keys.elementAt(index), lineData.values.elementAt(index)) ),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);
  },
);
  }
}
