import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http ;
import 'package:transport/ VoiceBroadcast/VoiceBroadcast.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _Map createState() => _Map();
}


class _Map extends State<Map> {

  late GoogleMapController mapController;
  late Position position ;
  //List<Marker> markers = [];
  late var locations ;
  LatLng _center = const LatLng(24.186277, 120.644793);
  var get = false ;
  // 偵測標點
  Future<void> RadarSearch(double latitude , double logitude) async{
    var url = 'http://10.0.2.2:8080/Radar/'+latitude.toString()+'/'+logitude.toString();
    var response = await http.get(Uri.parse(url));
    var newData ;

    if (response.statusCode == 200) {

        newData =json.decode(utf8.decode(response.bodyBytes));
        print(get);

        if(!newData.isEmpty && !get){
          print("hellllllo ssssss");
          VoiceBroadcast.play();
          get = true;
        }else{
          get = false ;
        }
    }
    //return newData ;
  }

  Future<void> getWholeLocation() async {
    var url = 'http://10.0.2.2:8080/WholeData/Location';
    var response = await http.get(Uri.parse(url));
    print("locaaaaaaaaaaaaaaaaaaaa");
    if(response.statusCode == 200){
      locations = json.decode(utf8.decode(response.bodyBytes));
    }

  }




  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.getVisibleRegion();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWholeLocation();
    getCurrentPosition() ;
    setPositionListener();

  }

  @override
  Widget build(BuildContext context) {
    //print("hello wrold");

    // marker add

    List<Marker> markers = [] ;

    final Marker marker = Marker(
      markerId: MarkerId("User_GPS"),
      position: _center,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );


    final Marker test = Marker(
      markerId: MarkerId("test"),
      position: LatLng(
          24.182, 120.651805),
      //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );

    markers.add(test);
    markers.add(marker);
    if(locations != null) {
      for (var location in locations) {
        markers.add(
            Marker(
              markerId: MarkerId(location['id'].toString()),
              position: LatLng(
                  location['gps_latitude'], location['gps_longitude']),

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
            )
        );
      }
    }

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

  getCurrentPosition() async {

    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //print(position.latitude.toString()+" "+position.longitude.toString());
    setState(() {
        _center = LatLng(position.latitude, position.longitude);
        print(position.latitude.toString()+" "+position.longitude.toString());
    });

  }

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
                " 事發原因: 機車竄出    今年事發次數 : 10次",
                style: TextStyle(
                    fontSize: 20
                ),
              )

          ),


        ],

      ),
    );
  }

  late String local ="" ;
  void setPositionListener(){

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    Geolocator.getPositionStream(locationSettings : locationSettings).listen((Position position) {
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        //print(position.latitude.toString()+" "+position.longitude.toString());
        RadarSearch(position.latitude, position.longitude);
        //transferPositionToAddress(position.latitude ,position.longitude);
      });
    });
  }


  Future<void> transferPositionToAddress(double latitude , double longitude)async {
    //print("transfer");
    List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);
    local = p[0].locality.toString();
    //print("loacl "+local);
    print(p[0].locality.toString());
  }

}


