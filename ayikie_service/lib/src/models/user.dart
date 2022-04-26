import 'package:ayikie_service/src/models/images.dart';

class User {
  String name;
  String address;
  String email;
  String phone;
  int role;
  Images imgUrl;

  User({
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.role,
    required this.imgUrl
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] == null ? "" : json['name'],
      address: json['address'] == null ? "" : json['address'],
      email: json['email'] == null ? "" : json['email'],
      phone: json['phone'] == null ? "" : json['phone'],
      role: 2,
      imgUrl: json['images'] != null ? Images.fromJson(json['images']):Images(id: 1, imageName: "https://ayikie.cyberelysium.app/img/logo/logo.png"),
    );
  }
}
