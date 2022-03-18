import 'package:flutter/material.dart';
import 'package:transport/SearchResource/Searchpage.dart';

class Search_tabbar extends StatefulWidget{

  @override
  _Search_tabbar createState() => _Search_tabbar();

}

class _Search_tabbar extends State<Search_tabbar>{


  @override
  Widget build(BuildContext context) {

    return AppBar(

        leading: IconButton(icon:Icon(Icons.arrow_back,size:40),
          onPressed: () {
            Navigator.pop(context);

          },
        ),

        // control the padding between leading and title
        titleSpacing: 10,

        // use Container to adjust the textfield height and width
        title: Container(
          width : 300 ,
          height: 40,
          // TextField section
          child:TextField(
            // To decorate the TextField
            // Input Section => InputDecoration
            decoration: InputDecoration(
              // put the search icon in the Textfield
              prefixIcon: Icon(Icons.search,size:30),
              // adjust the content location with contentPadding
              contentPadding: EdgeInsets.only(bottom:10),
              // Textfield Background , and filled is must be true
              fillColor:  Colors.white,
              filled: true,
              // adjust the textfield outward => outlineInputBorder

              border: OutlineInputBorder(
                // rounded corner
                borderRadius:BorderRadius.all(Radius.circular(25.0),
                ),
              ),
            ),

            // adjust the Text
            style: TextStyle(
                fontSize: 25
            ),

          ),
        ),

        // TabBar design
        bottom : TabBar(
            tabs: [Tab(icon : Icon(Icons.access_time)),
                   Tab(icon : Icon(Icons.archive)),
            ]
        )
    );
  }

}


