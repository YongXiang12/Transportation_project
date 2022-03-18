import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(24.186277, 120.644793);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      );

  }
}