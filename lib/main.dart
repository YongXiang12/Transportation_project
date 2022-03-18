import 'package:flutter/material.dart';
import 'package:transport/TabBarResource/Mainpage_tabbar.dart';
import 'package:transport/MapResource/Map.dart';
import 'package:transport/TabBarResource/TabBarInterface.dart';


void main() => runApp(const MyApp());



class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}


class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Map(),

            appBar: Tabbar_interface(pageType: 0),
            drawer: Drawer(

              child: ListView(

                children: [
                  DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 20),

                                child: Icon(
                                  Icons.account_box,size: 60,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("User_Name"
                                    , style: TextStyle(
                                      fontSize: 30 ,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Email_Adress"
                                    , style: TextStyle(
                                      fontSize: 20 ,
                                    ),
                                  ),
                                ],
                              )
                            ],
                        )
                    ),
                  ListTile(
                    title: const Text(
                      '導航',
                      style:TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    leading: Icon(Icons.airplanemode_active_outlined,size:30),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),ListTile(
                    title: const Text(
                      '儲存地點',
                      style:TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    leading: Icon(Icons.archive,size:30),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                        '登出',
                        style:TextStyle(
                          fontSize: 20,
                        ),
                    ),
                    leading: Icon(Icons.wrap_text,size:30),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                        '設定',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                    ),
                    leading: Icon(Icons.add,size: 30,),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  )



                ],


              ),



            ),
        )
      ),

    );


  }

}