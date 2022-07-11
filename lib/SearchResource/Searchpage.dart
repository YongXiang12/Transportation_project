import 'package:flutter/material.dart' ;
import 'package:provider/provider.dart';
import 'package:transport/SearchResource/GoogleMapChangeNotify.dart';
import 'package:transport/SearchResource/GoogleSearch.dart';
import 'package:transport/SearchResource/StorePage.dart';
import 'package:transport/TabBarResource/TabBarInterface.dart';
import 'package:transport/SearchResource/RecentSearchPage.dart';

class Searchpage extends StatefulWidget{
  int User_id = -1 ;

  Searchpage({Key? key , this.User_id =-1}) : super(key: key);

  @override
  _Searchpage createState() => _Searchpage() ;

}


class _Searchpage extends State<Searchpage>{


  @override
  Widget build(BuildContext context) {

    Tabbar_interface tab = Tabbar_interface(pageType : 1);

    return ChangeNotifierProvider(
        create: (context) => GoogleMapChangeNotify(),
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: tab,
                body: TabBarView(children: <Widget>[GoogleSearch(),StorePage(User_id : widget.User_id)])
            )
        ),

    );


  }

}