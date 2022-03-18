import 'package:flutter/material.dart' ;
import 'package:transport/TabBarResource/TabBarInterface.dart';
import 'package:transport/SearchResource/Search_listview.dart';

class Searchpage extends StatefulWidget{

  const Searchpage({Key? key}) : super(key: key);

  @override
  _Searchpage createState() => _Searchpage() ;
}

class _Searchpage extends State<Searchpage>{


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: Tabbar_interface(pageType : 1) ,
              body:Search_listview(),
          )
      );


  }

}