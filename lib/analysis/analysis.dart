import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transport/TabBarResource/TabBarInterface.dart';
import 'package:transport/SearchResource/Search_listview.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:transport/analysis/analysis_button.dart';

class analysis_page extends StatelessWidget {
  late List<SalesData> _chartData = getChartData();

  @override
  void initState() {
    _chartData = getChartData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("analysis"),
        ),
        body: SafeArea(
            child: Column(children: [
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            constraints: BoxConstraints(
                maxWidth: 400, maxHeight: 40, minWidth: 200, minHeight: 40),
            child: Row(
              children: <Widget>[
                Text("請選擇:"),
                Container(
                  alignment: Alignment.centerRight,
                  child: MyStatefulWidget(),
                  margin: EdgeInsets.only(left: 10, right: 10),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: MyStatefulWidget1(),
                  margin: EdgeInsets.only(left: 10, right: 10),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            constraints: BoxConstraints(
                maxWidth: 400, maxHeight: 300, minWidth: 200, minHeight: 250),
            decoration: new BoxDecoration(
              //背景

              color: Color.fromRGBO(255, 255, 255, 25),
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: new Border.all(
                  width: 1, color: Color.fromARGB(255, 104, 103, 103)),
            ),
            child: SfCartesianChart(
              title: ChartTitle(
                  text: '台中110年交通事故全部死亡人數',
                  borderWidth: 2,
                  // Aligns the chart title to left
                  alignment: ChartAlignment.center,
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  )),
              primaryXAxis: CategoryAxis(
                  axisLine: AxisLine(
                      color: Colors.deepOrange,
                      width: 2,
                      dashArray: <double>[5, 5])),
              primaryYAxis: NumericAxis(minimum: 10, maximum: 50),
              series: <ChartSeries>[
                LineSeries<SalesData, double>(
                    enableTooltip: true,
                    dataSource: _chartData,
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    markerSettings: MarkerSettings(
                        isVisible: true,
                        // Marker shape is set to diamond
                        shape: DataMarkerType.diamond),
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              constraints: BoxConstraints(
                  maxWidth: 400, maxHeight: 300, minWidth: 200, minHeight: 250),
              decoration: new BoxDecoration(
                //背景

                color: Color.fromRGBO(255, 255, 255, 25),
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: new Border.all(
                    width: 1, color: Color.fromARGB(255, 104, 103, 103)),
              )),
        ])));
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(1, 35),
      SalesData(2, 28),
      SalesData(3, 34),
      SalesData(4, 32),
      SalesData(5, 40),
      SalesData(6, 35),
      SalesData(7, 28),
      SalesData(8, 34),
      SalesData(9, 32),
      SalesData(10, 40),
      SalesData(11, 28),
      SalesData(12, 34)
    ];
    return chartData;
  }
}

mixin column {}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
