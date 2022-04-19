import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var newList ;

class StorePage extends StatefulWidget{

  @override
  _StorePage createState() => _StorePage();

}


class _StorePage extends State<StorePage>{

  // localhost : 10.0.2.2:8080

  Future<List> getData() async{
    var url = 'http://140.134.26.31:8080/PlaceData/';
    var response = await http.get(Uri.parse(url));
    var newData ;

    if (response.statusCode == 200) {
      setState(() {
        newData =json.decode(utf8.decode(response.bodyBytes));
      });
    }

    return newData ;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text("  儲存",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              )
          ),

          Expanded(
            child :  FutureBuilder<List>(
              future: getData(),
              builder: (context , snapshot){

                if(snapshot.hasError)
                  print(snapshot.error);

                newList = snapshot.data??[];
                return snapshot.hasData ? ItemList( list : snapshot.data??[]) : Center( child :CircularProgressIndicator());
              },
            ),
          )

        ],
      ),


    );
  }

}


class ItemList extends StatefulWidget{
  List list ;
  ItemList({Key? key, required this.list}) : super(key: key);
  _ItemList createState() => _ItemList(list :list);

}

class _ItemList extends State<ItemList>{

  List list;
  _ItemList({required this.list});

  @override
  Widget build(BuildContext context) {

      setState(() {
        list = newList;
      });

      void deleteData(String id) async {
        var url = 'http://140.134.26.31:8080/PlaceData/' + id;
        var response = await http.delete(Uri.parse(url));

        if (response.statusCode == 200) {


        } else {
          print('A network error occurred');
        }
      }

      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {

          return ListTile(

            title: Text(list[index]['placeName'],
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            subtitle: Text(list[index]['address']),
            leading: Icon(
              Icons.where_to_vote_sharp,
              color: Colors.blue,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                deleteData(list[index]['id'].toString());
              },
            ),

            onTap : null ,
          );
        },

      );
    }
}