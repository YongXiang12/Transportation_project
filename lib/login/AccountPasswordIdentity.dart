import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:transport/main.dart';

class AccountPasswordIdentity {


  static IndentityPassword(String email, String password,
      BuildContext context) async {
    print("hello http");
    print("world");
    var url = 'http://140.134.26.31:8080/User/'+ email;
    var response = await http.get(Uri.parse(url));
    var data = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      print("success");
      print(data[0]['password'].toString() + " " + password);
      if (data[0]['password'].toString().compareTo(password) == 0) {

        Navigator.pop(context , [data[0]['id'],data[0]['email']]);
      } else {
        _showDialog(context);
      }
      //return Future<bool>.value(true);;
    } else {
      print("Hello "+data[0]['password'].toString() + " " + password);
      print("false");
      return Future<bool>.value(false);;
    }
  }


  static Future<void>  showDialog(BuildContext context) async {

  }
}

// show the error email and password dialog

_showDialog(BuildContext context) async {
  var result = await showDialog(

    context: context,

    builder: (ctx) {

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Material(

              child: Container(
                width: 200,
                height: 50,
                child: Text(
                  "帳號或密碼錯誤",
                  style: TextStyle(fontSize: 20),
                ),
                alignment: Alignment.center,
              ),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),

               )
          ],

        ),
      );
    },
  );
}