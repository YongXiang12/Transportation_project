import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _Map createState() => _Map();
}



class _Map extends State<Map> {

  late GoogleMapController mapController;

  //List<Marker> markers = [];


  LatLng _center = const LatLng(24.186277, 120.644793);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    print("hello wrold");
    List<Marker> markers = [] ;

    final Marker marker = Marker(
      markerId: MarkerId("test"),
      position: _center,

      infoWindow: InfoWindow(
            title: '台中市西屯區文華路100號',
            snippet: "危險程度 高",
      ),

      onTap: () {
        showBottomSheet(

            context: context,
            builder: (builder) {
              return Container(
                child: _showMoreDetail(),
              );

              },
            );

      },
    );

    markers.add(marker);

    return
       Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: Set.from(markers),
        ),
      );

  }
  // TabBar(
  //             tabs: [Tab(icon : Icon(Icons.directions_car)),
  //               Tab(icon:Icon(Icons.directions_bike)),
  //               Tab(icon : Icon(Icons.directions_run)),
  //             ]
  DefaultTabController _showMoreDetail() {

      return
        DefaultTabController(
          length: 2,
          child :Column(
        mainAxisSize : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          ColoredBox(
              color: Colors.blue ,

              child: TabBar(
                  tabs: [
                    Tab(icon : Icon(Icons.announcement_rounded)),
                    Tab(icon:Icon(Icons.add_chart)),
                  ]
              ),

          ),

          Text(" 台中市西屯區文華路100號",
            style: TextStyle(
              fontSize: 30 ,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top :5 , bottom : 5),
            child:   Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(" 危險頻率 : ",
                  style: TextStyle(
                    fontSize: 20 ,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child:Icon(
                    Icons.wrong_location ,size: 40, color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top :20 , bottom : 20),
              child : Text(
                " 事發原因: 機車竄出",
                style: TextStyle(
                    fontSize: 20
                ),
              )

          ),


        ],

      ),
    );
  }



}


