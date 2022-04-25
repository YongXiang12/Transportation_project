import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transport/TabBarResource/TabBarInterface.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:transport/analysis/analysis_button.dart';

class analysis_page extends StatelessWidget {
  late List<SalesData> _chartData = getChartData();
  late List<GDPData> _chartData_GDP = getChartData_GDP();
  @override
  void initState() {
    _chartData = getChartData();
    _chartData_GDP = getChartData_GDP();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("analysis"),
        ),
        body: SafeArea(
            child: Column(children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            constraints: BoxConstraints(
                maxWidth: 250,
                maxHeight: MediaQuery.of(context).size.height * 0.05,
                minWidth: 200,
                minHeight: 10),
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
                maxWidth: 400,
                maxHeight: MediaQuery.of(context).size.height * 0.35,
                minWidth: 200,
                minHeight: 250),
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
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.43,
                      maxHeight: MediaQuery.of(context).size.height * 0.38,
                      minWidth: 100,
                      minHeight: 250),
                  decoration: new BoxDecoration(
                    //背景

                    color: Color.fromRGBO(255, 255, 255, 25),
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: new Border.all(
                        width: 1, color: Color.fromARGB(255, 104, 103, 103)),
                  ),
                  child: SfCircularChart(
                      title: ChartTitle(
                          text: '肇事交通工具件數',
                          textStyle: TextStyle(
                            fontSize: 14,
                          )),
                      legend: Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap,
                          textStyle: TextStyle(
                            fontSize: 12,
                          )),
                      series: <CircularSeries>[
                        DoughnutSeries<GDPData, String>(
                          dataSource: _chartData_GDP,
                          xValueMapper: (GDPData data, _) => data.continent,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        )
                      ]),
                ),
                Column(children: [
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.43,
                        maxHeight: MediaQuery.of(context).size.height * 0.16,
                        minWidth: 100,
                      ),
                      decoration: new BoxDecoration(
                        //背景

                        color: Color.fromRGBO(255, 255, 255, 25),
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: new Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 104, 103, 103)),
                      ),
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('台中交通死亡人數:283 '))),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.43,
                        maxHeight: MediaQuery.of(context).size.height * 0.16,
                        minWidth: MediaQuery.of(context).size.width * 0.43,
                        minHeight: MediaQuery.of(context).size.height * 0.16,
                      ),
                      decoration: new BoxDecoration(
                        //背景
                        color: Color.fromRGBO(255, 255, 255, 25),
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: new Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 104, 103, 103)),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: Text('與前年相比:')),
                            Container(
                                alignment: Alignment.center,
                                child: Text('減少43人(13.2%)'))
                          ]))
                ])
              ],
            ),
          )
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

  List<GDPData> getChartData_GDP() {
    final List<GDPData> chartData = [
      GDPData("行人", 1600),
      GDPData("大型車", 2900),
      GDPData("自小客車", 24800),
      GDPData("機車", 34390),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
