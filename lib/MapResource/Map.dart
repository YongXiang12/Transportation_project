import 'dart:async';
import 'dart:collection';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http ;
import 'package:transport/TabBarResource/Mainpage_tabbar.dart';
import '../TabBarResource/Mainpage_tabbar.dart';
import '../VoiceBroadcast/VoiceBroadcast.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as location_test;
import 'dart:ui' as ui;
import 'package:transport/VoiceBroadcast/fluttersound.dart';

late Main_page_tabbar tab ;
late String destination_id ;
late double destination_lat = -1 ;
late double destination_lng = -1;

class Map extends StatefulWidget {


  String t = "" ;

  Map({Key?  key ,  this.t =""}) : super(key: key);


  @override
  _Map createState() => temp = _Map(t);

  void setAppBar(Main_page_tabbar bar){
    tab = bar ;
    tab.getMapInstance(this);
  }

  void reset(){
    temp.reset_Map();
  }



  void setDestination(String dest){
    destination_id = dest ;
    print("click !!!"+destination_id);
    temp.getDestinationCorrdinate(destination_id);
  }
}


late _Map temp  ;
double _direction = 0.0;

String driving_type = "driving";
class _Map extends State<Map> {

  PolylinePoints polylinePoints = PolylinePoints();

  late HashMap<PolylineId , Polyline> polylines = new HashMap() ;
  int showBottomtype = 0 ;
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

  location_test.Location local_test = new location_test.Location();
  late location_test.LocationData locationdata ;
  late Uint8List markerIcon ;

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
        print("NewData "+newData.toString());

        if(!newData.isEmpty && !get){
          print("hellllllo ssssss "+newData[0]['id'].toString());

          for(var location in locations ){
            print(location['id']);
            if(location['id'].toString() == newData[0]['id'].toString()){
              sound_player.playAudio(location['main_cause']);
              //VoiceBroadcast.play(location['main_cause']);
              break ;
            }
          }
          //VoiceBroadcast.play(location['main_cause']);
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

    if(response.statusCode == 200){
      locations = json.decode(utf8.decode(response.bodyBytes));
      setAllRouteName();
    }


  setState(() {

  });

  }

  HashMap<String , String> route_names = new HashMap() ;
  String key = "AIzaSyAvKEY3UUeu3l4JjfHEouBdN6CScdoC68s";

  //路徑規劃
  // Direction api
  TravelMode TraveMode = TravelMode.driving ;
  Future<void> directionApi(int indentity) async {
    print("start direction");
    List<LatLng> Coordinates = [] ;

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        key, PointLatLng(_center.latitude, _center.longitude), PointLatLng(destination_lat,destination_lng),
        travelMode: TraveMode,
    );

    if(result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        Coordinates.add(LatLng(point.latitude , point.longitude));
      });
      print("Sucess!");
      if(indentity == 1)
         calculateNavigate();
      addPolyLine(Coordinates);
    }else{
      print("false!");
      print(result.errorMessage);
    }

  }





  void addPolyLine(List<LatLng> Coordinates){

    PolylineId id = PolylineId("GoogleMapLine");
    Polyline line = Polyline(
        polylineId: id,
        color: Colors.red,
        points : Coordinates ,
        width: 10 ,
    );

    polylines[id] = line ;

    setState(() {

    });

  }
  double degree = 0 ;
  List route_infomations  = [];
  String Navigate_Time = "";
  String distance_info = "";
  double pre_distence = 32767.0  ;

  Future<void> calculateNavigate()async {

    print("calculate !! " +driving_type);
    //List route_infomations = [] ;

    var url = Uri.parse("https://maps.googleapis.com/maps/api/directions/json?origin="+_center.latitude.toString()+","+_center.longitude.toString()+"&destination="+destination_lat.toString()+","+destination_lng.toString()+"&mode"+driving_type+"&key="+key);
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    print(json['routes'][0]['legs'][0]['steps']) ;
    print(_center.latitude.toString()+","+_center.longitude.toString()+" "+destination_lat.toString()+","+destination_lng.toString());

    route_infomations = json['routes'][0]['legs'][0]['steps'];
    Navigate_Time = json['routes'][0]['legs'][0]['duration']['text'];
    distance_info =  json['routes'][0]['legs'][0]['distance']['text'];
    print("Navigate Time = "+Navigate_Time);
    print(route_infomations.length);
    currentNavigateInStruction = 0 ;

    String str = route_infomations[0]['html_instructions'] ;

    print("str = "+str );
    if(str.contains('east')){
      degree = 90 ;
    }else if(str.contains('west')){
      degree = -90 ;
    }else if(str.contains('south')){
      degree = 180 ;
    }else if(str.contains('north')){
      degree = 0 ;
    }

    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng( _center.latitude,_center.longitude) , zoom:  22 , tilt: 90 , bearing: degree
            )
        )
    );

    showBottomSheet(
        enableDrag : false ,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        builder: (builder){
          print("hello Navigate Detail ");
          return _showMoreNavigateDetail();
        }
    );

  }

  int currentNavigateInStruction = 0 ;
  String routebehavior = "straight" ;
  void calculateCorrdinateWithUserGPS(){
    print(currentNavigateInStruction);

    if(currentNavigateInStruction >= route_infomations.length){
      currentNavigateInStruction = 1  ;
      route_infomations = [] ;
      return ;
    }

    double start_lat = route_infomations[currentNavigateInStruction]['start_location']['lat'] ;
    double start_lng = route_infomations[currentNavigateInStruction]['start_location']['lng'] ;

    double end_lat = route_infomations[currentNavigateInStruction]['end_location']['lat'] ;
    double end_lng = route_infomations[currentNavigateInStruction]['end_location']['lng'] ;


    print("start "+start_lat.toString()+" "+start_lng.toString()+" ");
    print("end "+end_lat.toString()+" "+end_lng.toString()+" ");
    print(_center.latitude.toString()+" "+_center.longitude.toString()+" ");
    print("size "+route_infomations.length.toString());
    if(route_infomations.length < 2){
      routebehavior = "straight";
    }else{
      routebehavior = route_infomations[1]['maneuver'] ;
    }

    // (_center.latitude >=  start_lat && _center.longitude >= start_lng  && _center.latitude <  end_lat && _center.longitude < end_lng ) || (_center.latitude <=  start_lat && _center.longitude <= start_lng  && _center.latitude >=  end_lat && _center.longitude >= end_lng )
    // ((_center.latitude < start_lat && _center.longitude > start_lng) || (_center.latitude > start_lat && _center.longitude < start_lng)) && ((_center.latitude < end_lat && _center.longitude > end_lng) || (_center.latitude > end_lat && _center.longitude < end_lng))

    print(((_center.latitude < start_lat && _center.longitude > start_lng) || (_center.latitude > start_lat && _center.longitude < start_lng)));
    print(((_center.latitude < end_lat && _center.longitude > end_lng) || (_center.latitude > end_lat && _center.longitude < end_lng)));
    print( (end_lat - start_lat )/ (end_lng - start_lng)) ;
    print( (end_lat - _center.latitude )/ (end_lng - _center.longitude) );

    double dis = calculateDistance(_center.latitude , _center.longitude , end_lat , end_lng);

    if(dis > pre_distence){
      print("redraw !!");
      directionApi(1);
      calculateNavigate();
      setState(() {
        print("error distance reset!!");
      });
    }

    pre_distence = dis ;
    if( ((end_lat - start_lat )/ (end_lng - start_lng) - (end_lat - _center.latitude )/ (end_lng - _center.longitude)).abs() < 1){




      if(dis < 150 && dis > 20){
         //TODO　the video
        VoiceBroadcast.reminderEarly(routebehavior);
      }

      if(dis < 20){
        VoiceBroadcast.routeVoicePlay(routebehavior);
        Navigator.pop(context);
        print("next route !!");
        directionApi(1);
        calculateNavigate();
        setState(() {
          print("reset!!");
        });
      }

    }else{
        print("redraw !!");
        directionApi(1);
        calculateNavigate();
        setState(() {
          print("reset!!");
        });
        currentNavigateInStruction = -1 ;
    }


  }

  Future<void> getLocationData() async{
    print("getLocationData+++++++++++++++++++++++++++");
    locationdata = await local_test.getLocation();

    if(type == "B"){
      markerIcon = await getBytesFromAsset('assets/car.png', 100);
    }else if(type == "C"){
      markerIcon = await getBytesFromAsset('assets/moto_3.png', 500);
      driving_type = "bicycling" ;
      TraveMode = TravelMode.bicycling ;
    }else if(type == "H"){
      markerIcon = await getBytesFromAsset('assets/person.png', 180);
      driving_type = "walking" ;
      TraveMode = TravelMode.walking ;
    }
     //markerIcon = await getBytesFromAsset('assets/moto_3.png', 500);
    //markerbitmap = await BitmapDescriptor.fromAssetImage(ImageConfiguration(),"assets/MapIcon.png");

    setState(() {

    });

  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    print("getBytesFromAsset++");
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2){

    double R = 6378137.0;
    double radLat1 = rad(lat1) ;
    double radLat2 = rad(lat2) ;

    double a = radLat1 - radLat2 ;
    double b  = rad(lon1) -  rad(lon2) ;
    double s = 2 * asin(sqrt(pow(sin(a/2),2)+ cos(radLat1) * cos(radLat2) * pow(sin(b/2),2)));
    //double C = sin(rad(lat1)) * sin(rad(lat2)) + cos(rad(lat1)) * cos(rad(lat2)) * cos(rad(lon1 - lon2));
    return (s * R).roundToDouble();

    /*
    double hsinX = sin((lon1 - lon2) * 0.5);
    double hsinY = sin((lat1 - lat2) * 0.5);
    double h = hsinY * hsinY +
        (cos(lat1) * cos(lat2) * hsinX * hsinX);
    return  2 * atan2(sqrt(h), sqrt(1 - h)) * 6367000;
    */
  }

  double rad(double d)
{
  return d * 3.14 / 180.0;
}


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

  List icon = [
    const Icon(
    Icons.access_time_outlined,
    color: const Color(0xFF167F67),
  )];



  Future<void> getDestinationCorrdinate(String destination_id) async{
    var url = Uri.parse("https://maps.googleapis.com/maps/api/place/details/json?place_id="+destination_id+"&language=zh-TW"+"&key="+key);
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    print(json);
    destination_lat = json['result']['geometry']['location']['lat'];
    destination_lng = json['result']['geometry']['location']['lng'];
    String address = json['result']['formatted_address'] ;
    String phone_number = json['result']['formatted_phone_number'];
    String name = json['result']['name'];
    List<String> infomations = [] ;
    infomations.add(address);
    infomations.add(phone_number);

    print(destination_lat.toString()+" coor "+destination_lng.toString());

    Marker m = Marker(
      markerId: MarkerId("test"),
      position: LatLng(destination_lat, destination_lng),
      icon : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),

      infoWindow:InfoWindow(
        title: name,
        snippet: address,
      ),
      onTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {

          //print("hello location"+(route_names[id].toString())+" "+id+" "+route_names.length.toString());
          return Container(
            width: 350,
            height: 350,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child:
                      Text(name , style:  TextStyle(
                        fontSize: 35 ,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  )
                  ],
                ),
                Center(
                  child: Row(

                    children: [

                      Container(
                          margin: EdgeInsets.only(right: 15 , left : 15 ),

                          child:
                          Column(
                            children: [
                            IconButton(
                               icon: const Icon(
                                  Icons.directions,
                                  color: Colors.blue,
                                  size: 30,

                                ),
                              onPressed: () {
                                 Navigator.pop(context);
                                 directionApi(0);
                              },
                              ),
                              const Text(
                                "規劃路線",
                                style: TextStyle(
                                  fontSize: 20 ,
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ],
                          ),


                      ),

                      Container(
                        margin: EdgeInsets.only(right: 15 , left : 15 ),

                        child:
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.directions,
                                color: Colors.blue,
                                size: 30,

                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                print("Center "+_center.longitude.toString()+" "+_center.latitude.toString());
                                directionApi(1);

                              },
                            ),
                            const Text(
                              "導航",
                              style: TextStyle(
                                  fontSize: 20 ,
                                  fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),


                      ),

                      Container(
                        margin: EdgeInsets.all(5),
                        child:
                        Column(

                          children: [
                          IconButton(
                            icon : const Icon(
                              Icons.archive,
                              color: Colors.blue,
                              size : 30,
                            ), onPressed: () {  },
                          ),
                            const Text(
                              "儲存",
                              style: TextStyle(
                                  fontSize: 20 ,
                                  fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  height: 150,
                  margin:EdgeInsets.only(top: 20),
                  child:  ListView(
                    children: [
                      Container(
                        width : 150 ,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(right: 10),
                        child:
                        Row(
                          children: [
                            const Icon(
                              Icons.add_location,
                              color: Colors.blue,
                              size: 35,
                            ),
                            SizedBox(width: 25)
                            ,
                        Flexible(
                          flex: 1,
                          child:
                            Text(
                              address,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20 ,
                                  fontWeight: FontWeight.w600,

                              ),
                            ),
                        )
                          ],
                        ),

                      ),

                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(right: 10),
                        child:
                        Row(

                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.blue,
                              size: 35,
                            ),
                            SizedBox(width: 25),

                           Text(
                                phone_number,
                                style: TextStyle(
                                    fontSize: 20 ,
                                    fontWeight: FontWeight.bold

                            )
                          ),

                          ],
                        ),

                      ),
                    ],

                  ),

                )

              ],
            ),

          );
        },
      );
    },

    );
    markers.add(m);
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(destination_lat ,destination_lng) , zoom:  25,tilt: 20
            )
        )
    );

    setState(() {
      print("direction !");
    });
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
    getLocationData();



  }

  // trying get rotate direction

  void rotateWithNavigate(){
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_center.latitude , _center.longitude),
          zoom: 25,
          bearing: locationdata.heading!
        )
      ),
    );
  }

  Container _showMoreNavigateDetail(){
  /*
    String nagative_direction = "直行" ;

    if(routebehavior == "turn-left"){
      nagative_direction = "左轉" ;
    }else if(routebehavior == "turn-right") {
      nagative_direction = "右轉" ;
    }else if(routebehavior == "uturn-right"){
      nagative_direction = "向右迴轉" ;
    }else if(routebehavior == "uturn-left"){
      nagative_direction = "向左迴轉" ;
    }
*/
    print("behavior "+routebehavior.toString());
    return Container(
      margin: EdgeInsets.only(left : 5 ),
      height: 120,
      color: Colors.white,
      child: Center(

        child: Row(

          children: [
                IconButton(
                  iconSize: 40,
                  icon: Image.asset('assets/cross2.png'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {

                    });
                  },
                  ),
                  Column(
                   children :[
                     Container(
                      margin: EdgeInsets.only(left : 65 , top : 30 , right : 20 ),
                      child:  Text( Navigate_Time ,
                          style: TextStyle(
                              fontSize: 40 ,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange
                          ),
                        )
                    ),
                     Text(
                       distance_info,
                       style: TextStyle(
                           fontSize: 20 ,
                           fontWeight: FontWeight.w600
                       ),
                     )
                   ]
                   ),
            IconButton(
              iconSize: 85,
              icon: Image.asset('assets/'+routebehavior+'.png'),
              onPressed: () {
                //Navigator.pop(context);
              },
            ),


          ],
        ),

        //onPressed: () => Navigator.pop(context),

      ),
    );


  }



  Set<Marker> markers = new Set();
  @override
  Widget build(BuildContext context) {

    //tab.setMap(m);

    //print("hello wrold");

    // marker add
    print("typeptpepepepepepepepep"+tab.getWeatherType().toString());


    final Marker marker = Marker(
      markerId: MarkerId("User_GPS"),
      rotation: locationdata.heading!,
      position: _center,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      draggable: true,
      onDragEnd: ((newPosition) {
        print(newPosition.latitude);
        print(newPosition.longitude);
        _center = new LatLng(newPosition.latitude, newPosition.longitude);
       // rotateWithNavigate();
        RadarSearch(newPosition.latitude, newPosition.longitude);
        print("end");
        if(destination_lat != null && destination_lat != -1) {
          calculateCorrdinateWithUserGPS();
        }

        mapController.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng( _center.latitude,_center.longitude) , zoom:  22 , tilt: 90 , bearing: degree
                )
            )
        );

        setState(() {

        });
      }),


    );



    int count = 0 ;
   // markers.add(test);
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

       floatingActionButton:
       Container(
         height: 65,
         width:  95,

         child: FloatingActionButton(
           child: Text("目前位置" ,
             style: TextStyle(
             fontSize: 15 ,
             fontWeight: FontWeight.bold,
            ),
           ),
           onPressed: (){
             mapController.animateCamera(
                 CameraUpdate.newCameraPosition(
                     CameraPosition(target: _center, zoom: 25)
                   //17 is new zoom level
                 )
             );
             //move position of map camera to new location
           },

         ),

       ),
        floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
        body: GoogleMap(
          compassEnabled:true ,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 25.0,
          ),
          markers: Set.from(markers),
          polylines: Set<Polyline>.of(polylines.values),
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

             // child:  Scaffold(
              //appBar :
              child:   TabBar(
                    tabs: [
                      Tab(icon : Icon(Icons.announcement_rounded)),
                      Tab(icon:Icon(Icons.add_chart)),
                    ]
                ),

              //  body: TabBarView(

              //    children: [],

               // ),

              ),

        //  ),
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