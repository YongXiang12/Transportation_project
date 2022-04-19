class PlaceSearch{
  final String placeId ;
  final String name ;
  final String address;

  PlaceSearch({required this.address , required this.placeId ,  required this.name});

  factory PlaceSearch.fromJson(Map<String , dynamic> json){

    return PlaceSearch(address:json['structured_formatting']['secondary_text'],
                       placeId : json['place_id'],
                       name : json["structured_formatting"]['main_text']);
  }


}