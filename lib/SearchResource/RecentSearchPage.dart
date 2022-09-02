import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'StorePage.dart';

class RecentSearchPage extends StatefulWidget{


  @override
  _RecentSearchPage createState() => _RecentSearchPage();

}



class _RecentSearchPage extends State<RecentSearchPage>{

  @override
  void initState() {
    //getData();
    super.initState();
  }

  @override
  void didChangeDependencies(){
    //getData();
    super.didChangeDependencies();
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text("  最近",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              )
          ),

          /*
          Expanded(
              child : null
          )
          */

        ],
      ),


    );
  }


}
