import 'package:flutter/material.dart';
import 'package:transport/SearchResource/Searchpage.dart';
import 'package:provider/provider.dart';
import 'package:transport/main.dart';
import 'package:transport/MapResource/Map.dart';

late Map currMap ;
int weather_type = 8 ;
String destination = "" ;
late Map map ;

class Main_page_tabbar extends StatefulWidget implements PreferredSizeWidget {

  int User_id = -1;
 // late Map CarMap ;
 // late Map BikeMap  ;
 // late Map HumanMap   ;


  List<Map> maps = [] ;

  Main_page_tabbar({Key? key, this.User_id = -1 , required this.maps/*required this.CarMap , required this.BikeMap , required this.HumanMap*/}) : super(key: key);

  late _Main_page_tabbar temp ;

  @override
  _Main_page_tabbar createState() =>  temp = _Main_page_tabbar();



  void setMap(String t){

    if(t == "B"){
      currMap = maps[0] ;
      print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
    }else if(t == "C"){
      currMap = maps[1] ;
      print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
    }else if(t == "H"){
      currMap = maps[2] ;
      print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    }

  }

  void getMapInstance(Map m){
    map = m ;
  }

  int getWeatherType(){
    return weather_type ;
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);

}



class Item {
  const Item(this.icon);
  final Icon icon;
}


class _Main_page_tabbar extends State<Main_page_tabbar>{

  int User_id = -1;
  late Icon default_icon = icon[0] ;

  List icon = [
    const Icon(
      Icons.wb_sunny_outlined,
      color: const Color(0xFF167F67),
    ),
    const Icon(
      Icons.wb_cloudy_outlined,
      color: const Color(0xFF167F67),
    ),
    const Icon(
      Icons.wb_cloudy,
      color: const Color(0xFF167F67),
    ),
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
        //titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            Provider.of<MyCounter>(context, listen: false).contorldrawer();
            print('zvxbdjwnjbjdngs');
          },
        ),
        // use Container to adjust the textfield height and width
        title: Container(
          width: 250,
          height: 40,
          // TextField section
          child: TextField(
            focusNode: _KeyboardFocusNode,
            // To decorate the TextField
            // Input Section => InputDecoration
            decoration: InputDecoration(
              // put the search icon in the Textfield
              prefixIcon: Icon(Icons.search, size: 30),
              // adjust the content location with contentPadding
              contentPadding: EdgeInsets.only(bottom: 10),
              // Textfield Background , and filled is must be true
              fillColor: Colors.white,
              filled: true,
              // adjust the textfield outward => outlineInputBorder

              border: OutlineInputBorder(
                // rounded corner
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
            ),

            // adjust the Text
            style: TextStyle(fontSize: 25),
            onTap: () async {

              _KeyboardFocusNode.unfocus();
              destination = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Searchpage(User_id: widget.User_id)));
              map.setDestination(destination);

            },
          ),
        ),
        actions: [
          Container(
            width: 80,
            height: 40,
            child: DropdownButton<Icon>(

              /*
                underline: Container(height: 0),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),

               */
                value: default_icon,
                items: icon.map((user){
                    return DropdownMenuItem<Icon>(
                        value: user,
                        child:user,

                    );
                }).toList(),


                onChanged: (value){
                  print(value.runtimeType);
                  setState(() {

                    default_icon = value! ;

                    if(default_icon == icon[0]){
                      weather_type = 8 ;
                    }else if(default_icon == icon[1]){
                      weather_type = 7 ;
                    }else if(default_icon == icon[2]){
                      weather_type = 6 ;
                    }
                    currMap.reset();
                  });
                },
                ),
          )
        ],

        // TabBar design
        bottom: TabBar(tabs: [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_bike)),
          Tab(icon: Icon(Icons.directions_run)),
        ]));
  }

  void setMap(Map m ){
    print("iiiiiiiiiiiiiiiiiiiiiiii");
    map = m;
  }

}
