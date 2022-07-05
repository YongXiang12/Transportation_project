class UserModel{
  final String? email;
  final String? id;
  final String? name;
  final PictureModel? pictureModel;

  const UserModel({this.name, this.pictureModel, this.email, this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
          email: json['email'],
          id: json['id'] as String?,
          name: json['name'],
          pictureModel: PictureModel.fromJson(json['picture']['data'])
      );


/*
  Sample result of get user data method
  {
    "email" = "dsmr.apps@gmail.com",
    "id" = 3003332493073668,
    "name" = "Darwin Morocho",
    "picture" = {
        "data" = {
            "height" = 50,
            "is_silhouette" = 0,
            "url" = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3003332493073668",
            "width" = 50,
        },
    }
}
   */
}

class PictureModel{
  final String? url;
  final int? width;
  final int? height;

  const PictureModel({this.width, this.height, this.url});

  factory PictureModel.fromJson(Map<String, dynamic> json) =>
      PictureModel(
          url: json['url'],
          width: json['width'],
          height: json['height']
      );
}