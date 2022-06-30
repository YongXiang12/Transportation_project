import 'package:flutter/material.dart';
import 'package:transport/SearchResource/GoogleMapAutoSearch.dart';
import 'package:transport/SearchResource/PlaceSearch.dart';

class GoogleMapChangeNotify with ChangeNotifier{

  final placeService = GoogleMapAutoSearch();

  List<PlaceSearch> result = [];

  searchPlace(String search) async{
    result =   await placeService.getAutocomplete(search);
    notifyListeners();
    //return result;
  }


}