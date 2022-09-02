//@dart=2.12
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/TabBarResource/Mainpage_tabbar.dart';
import 'package:transport/MapResource/Map.dart';
import 'package:transport/TabBarResource/TabBarInterface.dart';
import 'package:transport/analysis/analysis.dart';
import 'package:transport/login/logins.dart';
import 'dart:math';

import 'package:transport/setting/setting.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: MyCounter(0, "107", 0))],
      child: MaterialApp(home: Myhome()),
    );
  }
}

class Myhome extends StatefulWidget {
  @override
  _Myhome createState() => _Myhome();
}

double value = 0;

class _Myhome extends State<Myhome> {
  int id = -1;
  var list;
  String email = "";
  bool isLogin = false;
  String status = "登入";
  String User_name = "";

  late Map CarMap;
  late Map BikeMap;
  late Map HumanMap;
  late List<Map> maps;

  late Main_page_tabbar tab;

  @override
  void initState() {
    // TODO: implement initState
    CarMap = new Map(t: "B");
    BikeMap = new Map(t: "C");
    HumanMap = new Map(t: "H");

    maps = [CarMap, BikeMap, HumanMap];

    tab = Main_page_tabbar(
      User_id: id,
      maps: maps /*CarMap: this.CarMap , BikeMap: BikeMap, HumanMap: HumanMap*/,
    );
    CarMap.setAppBar(tab);
    BikeMap.setAppBar(tab);
    HumanMap.setAppBar(tab);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(66, 165, 245, 1),
                      Color.fromRGBO(21, 101, 192, 1),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DrawerHeader(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                  "https://i.pinimg.com/originals/1d/90/00/1d9000c7502195316846ff6b02e3f51c.png"),
                            ),
                            SizedBox(height: 10.0),
                            Text(User_name,
                                style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                          ],
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          '導航',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        leading: Icon(Icons.airplanemode_active_outlined,
                            size: 30, color: Colors.white),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text(
                          '儲存地點',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        leading: Icon(Icons.archive, size: 30, color: Colors.white),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text(
                          status,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        leading:
                        Icon(Icons.login_rounded, size: 30, color: Colors.white),
                        onTap: () async {
                          list = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                          update();
                        },
                      ),
                      ListTile(
                        title: const Text(
                          '設定',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        leading: Icon(Icons.add, size: 30, color: Colors.white),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => setting_page()));
                        },
                      ),
                      ListTile(
                        title: const Text(
                          '分析',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        leading:
                        Icon(Icons.wrap_text, size: 30, color: Colors.white),
                        onTap: () {
                          //Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => analysis_page()));

                          // Update the state of the app
                          // ...
                          // Then close the drawer
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<MyCounter>(builder: (context, counter, _) {
                return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: counter.count),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInExpo,
                    builder: (_, double val, __) {
                      return (Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..setEntry(0, 3, 200 * val)
                          ..rotateY((pi / 6) * val),
                        child: Scaffold(
                          appBar: tab
                          /*
                      Tabbar_interface(
                        pageType: 0,
                        User_id: id,
                      )*/
                          ,
                          body: TabBarView(
                            children: <Widget>[
                              Map(t: "B"),
                              Map(t: "C"),
                              Map(t: "H")
                            ],
                            physics: new NeverScrollableScrollPhysics(),
                          ),
                        ),
                      ));
                    });
              }),
            ])));
  }

  void update() {
    setState(() {
      print("hello");
      print(list);
      email = list[1];
      id = list[0];
      print(id.toString());
      isLogin = !isLogin;
      if (isLogin) {
        status = "登出";
      }
      User_name = "張詠翔";
      tab = Main_page_tabbar(
        User_id: id,
        maps:
        maps /*CarMap: this.CarMap , BikeMap: BikeMap, HumanMap: HumanMap*/,
      );
      CarMap.setAppBar(tab);
      BikeMap.setAppBar(tab);
      HumanMap.setAppBar(tab);
    });
  }
}

class MyCounter extends ChangeNotifier {
  double _count;
  String _year = "110";
  int _use_setting = 0;
  get count => _count;
  get year => _year;
  get use_setting => _use_setting;
  MyCounter(this._count, this._year, this._use_setting);
  contorldrawer() {
    _count == 0 ? _count = 1 : _count = 0;
    print(_count);
    notifyListeners();
  }

  selectsetting(int value) {
    _use_setting = value;
    notifyListeners();
  }

  contorlyear(String newyear) {
    _year = newyear;
    print(_year + "12312313");
    notifyListeners();
  }

  static of(BuildContext context) {}
}
