import 'package:flutter/material.dart' ;
import 'package:transport/SearchResource/Searchpage.dart';
import 'package:transport/TabBarResource/Mainpage_tabbar.dart';
import 'package:transport/TabBarResource/Search_tabbar.dart';

class Tabbar_interface extends StatefulWidget implements PreferredSizeWidget{

  int pageType = 0 ;
  int User_id = -1;
   //constructor
  Tabbar_interface({Key? key, this.pageType = 0 , this.User_id = -1 }) : super(key: key);

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
         // return Main_page_tabbar(User_id : widget.User_id);
      case 1 :
          return Search_tabbar();
      default :
        return Scaffold();
    }


  }



}