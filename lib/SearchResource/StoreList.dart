class StoreList {
  int? id;
  int? type;
  String? address;
  String? placeName;

  StoreList({this.id, this.type, this.address, this.placeName});

  StoreList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    address = json['address'];
    placeName = json['placeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['address'] = this.address;
    data['placeName'] = this.placeName;
    return data;
  }
}