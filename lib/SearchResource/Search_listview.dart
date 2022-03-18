import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Search_listview extends StatefulWidget{


  @override
  _Search_listview createState() => _Search_listview();

}

class _Search_listview extends State<Search_listview>{

  // modify the List
  List<Widget> searchList = <Widget>[

      ListTile(
        title: const Text(
          '逢甲大學',
          style : TextStyle(fontWeight: FontWeight.w600 , fontSize: 20),

        ),
        subtitle: const Text('407102 台中市西屯區文華路100號'),

        leading: Icon(
          Icons.where_to_vote_sharp,
          color : Colors.blue ,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {  },
        ),
      ),

    ListTile(
      title: const Text(
        '台中火車站',
        style : TextStyle(fontWeight: FontWeight.w600 , fontSize: 20),

      ),
      subtitle: const Text('400台中市中區台灣大道一段1號'),

      leading: Icon(
        Icons.where_to_vote_sharp,
        color : Colors.blue ,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {  },
      ),
    ),


  ];


  @override
    Widget build(BuildContext context) {

      return Scaffold(
        body: Column(
          crossAxisAlignment :CrossAxisAlignment.start,

          children:<Widget> [
            Container(
              padding: EdgeInsets.only(top: 20,bottom:20),
              child :Text("  最近" ,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              )
            ),

            Expanded(
                child :ListView(
                  children: searchList,
                )
            )

          ],
        ),


        );

    }


}