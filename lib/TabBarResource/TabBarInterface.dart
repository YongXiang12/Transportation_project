import 'package:flutter/material.dart' ;
import 'package:transport/TabBarResource/Mainpage_tabbar.dart';
import 'package:transport/TabBarResource/Search_tabbar.dart';
class Tabbar_interface extends StatefulWidget implements PreferredSizeWidget{

  int pageType = 0 ;
   //constructor
  Tabbar_interface({Key? key, this.pageType = 0 }) : super(key: key);

  @override
  _Tabbar_interface createState() => _Tabbar_interface();

  @override
  Size get preferredSize => const Size.fromHeight(100);

}

class _Tabbar_interface extends State<Tabbar_interface>{

  @override
  Widget build(BuildContext context) {

    switch(widget.pageType){
      case 0 :
          return Main_page_tabbar();
      case 1 :
          return Search_tabbar();
      default :
        return Scaffold();
    }


  }



}