import 'dart:async';
import 'dart:collection';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http ;
import 'package:transport/TabBarResource/Mainpage_tabbar.dart';
import '../TabBarResource/Mainpage_tabbar.dart';
import '../VoiceBroadcast/VoiceBroadcast.dart';

late Main_page_tabbar tab ;

class Map extends StatefulWidget {


  String t = "" ;

  Map({Key?  key ,  this.t =""}) : super(key: key);


  @override
  _Map createState() => temp = _Map(t);

  void setAppBar(Main_page_tabbar bar){
    tab = bar ;
  }

  void reset(){
    temp.reset_Map();
  }
}

late _Map temp  ;

class _Map extends State<Map> {
  late String type ;
 // late Main_page_tabbar tab ;
  late Map m ;
  late String name = "" ;

  _Map(String t){
    print("hello world");
    type = t ;
    tab.setMap(t);
    //tab = tabbar ;
    //m = m ;
    print("end world");
  }


  late GoogleMapController mapController;
  late Position position ;
  //List<Marker> markers = [];
  late var locations ;
  LatLng _center = const LatLng(24.186277, 120.644793);
  var get = false ;
  // 偵測標點
  Future<void> RadarSearch(double latitude , double logitude) async{
    print("hello radar");
    var url = 'http://140.134.26.31:8080/Radar/'+latitude.toString()+'/'+logitude.toString();
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
          print("fail");
          get = false ;
        }
    }else{
      print("");
    }
    //return newData ;
  }

  Future<void> getWholeLocation() async {

    var url = 'http://140.134.26.31:8080/WholeData/Location/'+type+"/"+tab.getWeatherType().toString();
    var response = await http.get(Uri.parse(url));
    print("locaaaaaaaaaaaaaaaaaaaa");
    if(response.statusCode == 200){
      locations = json.decode(utf8.decode(response.bodyBytes));
      setAllRouteName();
    }


  setState(() {

  });

  }

  HashMap<String , String> route_names = new HashMap() ;
  String key = "AIzaSyAvKEY3UUeu3l4JjfHEouBdN6CScdoC68s";
  //componets=contry:TW
  Future<void> getRouteName(double latitude , double longitude , int id) async{
    var url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng="+latitude.toString()+","+longitude.toString()+"&language=zh-TW&key="+key);
    var response = await http.get(url);
    https://maps.googleapis.com/maps/api/geocode/json?latlng=24.182 ,120.651805&language=zh-TW&key=AIzaSyAvKEY3UUeu3l4JjfHEouBdN6CScdoC68s
    var json = convert.jsonDecode(response.body);
    //print("NNNNNNNNNNNNNNNNNN"+json['results'][0]['formatted_address']);
    name = json['results'][0]['formatted_address'] ;
    route_names[id.toString()] = name;
    //print(id.toString()+"NNNNNNNNNNNNNNNNNN"+name+" "+route_names[id.toString()].toString());


  }


  void setAllRouteName(){

    for(var location in locations){
      getRouteName(location['gps_latitude'], location['gps_longitude'] , location['id']);

      print(location['id'].toString() +" name "+name);
    }


  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.getVisibleRegion();
  }

  @override
  void initState() {
    // TODO: implement initState
    print("init");
    super.initState();
    getWholeLocation();
    getCurrentPosition() ;
    setPositionListener();

  }

  @override
  Widget build(BuildContext context) {

    //tab.setMap(m);

    //print("hello wrold");

    // marker add
    print("typeptpepepepepepepepep"+tab.getWeatherType().toString());
    List<Marker> markers = [] ;

    final Marker marker = Marker(
      markerId: MarkerId("User_GPS"),
      position: _center,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      draggable: true,
      onDragEnd: ((newPosition) {
        print(newPosition.latitude);
        print(newPosition.longitude);
        RadarSearch(newPosition.latitude, newPosition.longitude);
        print("end");
      }),


    );


    final Marker test = Marker(
      markerId: MarkerId("test"),
      position: LatLng(
          24.182, 120.651805),
      //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );

    int count = 0 ;
    markers.add(test);
    markers.add(marker);
    if(locations != null) {
      for (var location in locations) {
        String id = location['id'].toString() ;

        //(location['gps_latitude'], location['gps_longitude']);
        Marker route  =   Marker(
          markerId: MarkerId(count.toString()),
          position: LatLng(
              location['gps_latitude'], location['gps_longitude']),

          infoWindow: InfoWindow(
            title: route_names[id],
            snippet: "危險程度 高",
          ),

          onTap: () {
            showBottomSheet(
              context: context,
              builder: (builder) {

                print("hello location"+(route_names[id].toString())+" "+id+" "+route_names.length.toString());
                return Container(
                  child: _showMoreDetail(location['main_cause'] ,  route_names[id].toString() ),
                );
              },
            );
          },
        );
        markers.add(route
        );
        count++ ;
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

  DefaultTabController _showMoreDetail(String cause, String name) {
      print("show "+name);
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

          Text(name,
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
                " 事發原因: "+cause,
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
      print("helloGGGGGG");
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        print("hello");
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

  void reset_Map(){
    setState(() {
      getWholeLocation();
    });
  }

}


