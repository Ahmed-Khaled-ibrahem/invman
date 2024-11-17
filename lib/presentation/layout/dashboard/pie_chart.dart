import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class PieChartWidget extends StatelessWidget {
   PieChartWidget(this.pieData, {Key? key}) : super(key: key);

   Map<String, double> pieData ;

  @override
  Widget build(BuildContext context) {

    List<ChartData> data = List.generate(pieData.length, (index) => ChartData(pieData.keys.elementAt(index), pieData.values.elementAt(index)));

    return SfCircularChart(
        title: ChartTitle(
            text: 'Best Selling',
            // Aligns the chart title to left
            alignment: ChartAlignment.near,
            textStyle: Theme.of(context).textTheme.bodyLarge
        ),
        palette: const <Color>[Colors.amber, Colors.brown, Colors.green, Colors.redAccent, Colors.blueAccent, Colors.teal],
        legend: Legend(isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap
        ),

        tooltipBehavior: TooltipBehavior(
          enable: true,
          borderWidth: 5,
        ),

        series: <CircularSeries<ChartData,String>>[
          // Render pie chart
          PieSeries<ChartData, String>(
              dataSource: data,
              // pointColorMapper:(ChartData data,  _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              animationDuration: 1000,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                alignment: ChartAlignment.near,
                labelPosition: ChartDataLabelPosition.inside,
              )
          )
        ]
    );
  }
}
