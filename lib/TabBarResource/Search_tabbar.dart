import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:transport/SearchResource/GoogleMapChangeNotify.dart';
import 'package:transport/SearchResource/Searchpage.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import '../SearchResource/GoogleSearch.dart';

class Search_tabbar extends StatefulWidget{

  const Search_tabbar({Key? key}) : super(key: key);


  @override
  _Search_tabbar createState() => _Search_tabbar();

  @override
  Size get preferredSize => const Size.fromHeight(100);

}

int SelectType = 0 ;

class _Search_tabbar extends State<Search_tabbar>{

  @override
  Widget build(BuildContext context) {
    FocusNode _KeyboardFocusNode = FocusNode();

    return AppBar(



        leading: IconButton(icon:Icon(Icons.arrow_back,size:40),
        onPressed: () {
            Navigator.pop(context);
          },
        ),

        // control the padding between leading and title
        titleSpacing: 10,
        title: Text("地點搜尋" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        // use Container to adjust the textfield height and width

        bottom: TabBar(
            tabs: [Tab(icon : Icon(Icons.search)),
                   Tab(icon : Icon(Icons.archive)),
            ]
        )
    );
  }

}


