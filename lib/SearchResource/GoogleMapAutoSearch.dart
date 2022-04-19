import 'PlaceSearch.dart' ;
import 'package:http/http.dart' as http ;
import 'dart:convert' as convert;

class GoogleMapAutoSearch{

  String key = "AIzaSyAvKEY3UUeu3l4JjfHEouBdN6CScdoC68s";
//componets=contry:TW
  Future<List<PlaceSearch>> getAutocomplete(String search) async{
    var url = Uri.parse("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search=&types=establishment&key=$key");
    var response = await http.get(url);
    print("AutoSearch");
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['predictions'] as List ;
    return jsonResult.map((place) => PlaceSearch.fromJson(place)).toList() ;
  }

}