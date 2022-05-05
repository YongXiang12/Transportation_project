import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/TabBarResource/Mainpage_tabbar.dart';
import 'package:transport/MapResource/Map.dart';
import 'package:transport/TabBarResource/TabBarInterface.dart';
import 'package:transport/analysis/analysis.dart';
import 'package:transport/login/logins.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Myhome(),
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
                              "data:image/jpeg;base64,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"),
                        ),
                        SizedBox(height: 10.0),
                        Text("張詠翔",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
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
                        Icon(Icons.wrap_text, size: 30, color: Colors.white),
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
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
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
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
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
                    appBar: Tabbar_interface(
                      pageType: 0,
                      User_id: id,
                    ),
                    body: Map(),
                  ),
                ));
              }),
          //Map(),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            }, /*onTap: () {
            setState(() {
              value == 0 ? value = 1 : value = 0;
            });
          }*/
          )
        ])));
  }

  void update() {
    setState(() {
      print("hello");
      print(list);
      email = list[1];
      id = list[0];
      isLogin = !isLogin;
      if (isLogin) {
        status = "登出";
      }
    });
  }
}
