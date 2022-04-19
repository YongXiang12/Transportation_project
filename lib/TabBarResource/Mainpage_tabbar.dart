import 'package:flutter/material.dart';
import 'package:transport/SearchResource/Searchpage.dart';

class Main_page_tabbar extends StatefulWidget{

  @override
  _Main_page_tabbar createState() => _Main_page_tabbar();


}

class Item{
  const Item(this.icon);
  final Icon icon;
}

class _Main_page_tabbar extends State<Main_page_tabbar>{
  String Weather = "晴天";
  List icon = [
    const Item(Icon(Icons.wb_sunny_outlined,color:  const Color(0xFF167F67),)),
    const Item(Icon(Icons.wb_cloudy_outlined,color:  const Color(0xFF167F67),)),
    const Item(Icon(Icons.wb_sunny_outlined,color:  const Color(0xFF167F67),)),
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    // to hide the mobile keyboard

    FocusNode _KeyboardFocusNode = FocusNode();

    return AppBar(

        // control the padding between leading and title
        titleSpacing: 10,

        // use Container to adjust the textfield height and width
        title: Container(
          width : 250 ,
          height: 40,
          // TextField section
          child:TextField(
            focusNode: _KeyboardFocusNode,
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
            onTap: (){
              _KeyboardFocusNode.unfocus();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Searchpage()));
            },
          ),
        ),

        actions: [
          Container(
            width : 80 ,
            height: 40,
            child:  DropdownButton<String>(
                underline: Container(height : 0),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),



                value: Weather,
                items: <String>['晴天', '雨天', '多雲'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(

                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                onChanged : (newWeather){
                  setState(() {
                    Weather = newWeather! ;
                  });

                }
            ),
          )

        ],


        // TabBar design
        bottom : TabBar(
            tabs: [Tab(icon : Icon(Icons.directions_car)),
              Tab(icon:Icon(Icons.directions_bike)),
              Tab(icon : Icon(Icons.directions_run)),
            ]
        )
    );
  }

}


