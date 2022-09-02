import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:transport/TabBarResource/TabBarInterface.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:transport/analysis/analysis_button.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:transport/main.dart';

class analysis_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _analysis_page_state();
}

class _analysis_page_state extends State<analysis_page> {
  String year = "110";
  String kind = "死亡人數", select_kind = "1";
  var die = {
    '106': '217',
    '107': '245',
    '108': '270',
    '109': '235',
    '110': '280',
  };
  var decrease = {
    '107': '28',
    '108': '25',
    '109': '35',
    '110': '45',
  };
  var Variety = {
    '107': '增加',
    '108': '增加',
    '109': '減少',
    '110': '增加',
  };
  var percentage = {
    '107': '12.9',
    '108': '10.2',
    '109': '20.4',
    '110': '13.8',
  };
  double maxnum = 50, minnum = 10;
  List<SalesData> chartData = [];
  List<GDPData> gdpData = [];
  //late List<GDPData> _chartData_GDP = getChartData_GDP();

  @override
  Future loadSalesData() async {
    int k = 0;
    chartData = [];
    final String jsonString = await getJsonFromAssets();
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      chartData.add(SalesData.fromJson(i));
      print("有執行");
      print(chartData[k++].date);
    }
  }

  Future<String> getJsonFromAssets() async {
    return await rootBundle
        .loadString('assets/data_' + year + '_' + select_kind + '.json');
  }

  Future loadGdpData() async {
    int k = 0;
    gdpData = [];
    final String jsonString = await getJsonFromAssets2();
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      gdpData.add(GDPData.fromJson(i));
      print("有執行");
      print(gdpData[k++].continent);
    }
  }

  Future<String> getJsonFromAssets2() async {
    return await rootBundle.loadString('assets/data_' + year + '.json');
  }
  /*void initState() {
    //_chartData = getChartData();
    _chartData_GDP = getChartData_GDP();
    loadSalesData();
    print("xxxxxxxxxxxinsert");
  }*/

  Widget build(BuildContext context) {
    final counter = Provider.of<MyCounter>(context);
    print("第一次載入110");
    loadSalesData();
    loadGdpData();
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
                minWidth: 100,
                minHeight: 10),
            child: Row(
              children: <Widget>[
                Text("請選擇:"),
                Container(
                  alignment: Alignment.centerRight,
                  child: DropdownButton<String>(
                    value: year,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        year = newValue!;
                        print(newValue);
                        print(year);
                        print("更換年份");
                        loadSalesData();
                        loadGdpData();
                      });
                    },
                    items: <String>['110', '109', '108', '107']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  margin: EdgeInsets.only(left: 10, right: 5),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: DropdownButton<String>(
                    value: kind,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        kind = newValue!;
                        if (kind == "死亡人數") {
                          select_kind = "1";
                        } else if (kind == "受傷人數") {
                          select_kind = "2";
                        } else {
                          select_kind = "3";
                        }
                        print("更換種類");
                        select_kind == "1" ? maxnum = 50 : maxnum = 7000;
                        select_kind == "1" ? minnum = 10 : minnum = 3500;
                        loadSalesData();
                      });
                    },
                    items: <String>['死亡人數', '受傷人數', '死傷人數']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  margin: EdgeInsets.only(left: 10, right: 5),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
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
              child: FutureBuilder(
                  future: getJsonFromAssets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("snapshot: $snapshot");
                      //loadSalesData();
                      return SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis:
                              NumericAxis(minimum: minnum, maximum: maxnum),
                          // Chart title
                          title: ChartTitle(
                              text: '台中' + year + '年交通事故全部' + kind,
                              borderWidth: 2,
                              // Aligns the chart title to left
                              alignment: ChartAlignment.center,
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              )),
                          series: <ChartSeries<SalesData, String>>[
                            LineSeries<SalesData, String>(
                                enableTooltip: true,
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) =>
                                    sales.date,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.value,
                                markerSettings: MarkerSettings(
                                    isVisible: true,
                                    // Marker shape is set to diamond
                                    shape: DataMarkerType.diamond),
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true))
                          ]);
                    } else {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          height: 100,
                          width: 400,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Retriving JSON data...',
                                    style: TextStyle(fontSize: 20.0)),
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    semanticsLabel: 'Retriving JSON data',
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blueAccent),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  })),
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
                    child: FutureBuilder(
                      future: getJsonFromAssets2(),
                      builder: (context, snapshot) {
                        print("snapshot: $snapshot");
                        //loadSalesData();
                        return SfCircularChart(
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
                                dataSource: gdpData,
                                xValueMapper: (GDPData data, _) =>
                                    data.continent,
                                yValueMapper: (GDPData data, _) => data.gdp,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                              )
                            ]);
                      },
                    )),
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text('  台中交通死亡人數:',
                                    style: TextStyle(color: Colors.black))),
                            Container(
                                alignment: Alignment.center,
                                child: Text(die[year].toString(),
                                    style: TextStyle(
                                      fontSize: 60,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontStyle: FontStyle.italic,
                                    ))),
                          ])),
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
                                child: Text(Variety[year].toString() +
                                    decrease[year].toString() +
                                    '人' +
                                    '(' +
                                    percentage[year].toString() +
                                    '%)'))
                          ]))
                ])
              ],
            ),
          )
        ])));
  }

  /*List<SalesData> getChartData() {
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
  }*/

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
  factory GDPData.fromJson(Map<String, dynamic> parsedJson) {
    return GDPData(
      parsedJson['data'].toString(),
      parsedJson['value'],
    );
  }
}

class SalesData {
  SalesData(this.date, this.value);

  final String date;
  final int value;

  factory SalesData.fromJson(Map<String, dynamic> parsedJson) {
    return SalesData(
      parsedJson['date'].toString(),
      parsedJson['value'],
    );
  }
}
