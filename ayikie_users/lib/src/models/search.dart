import 'package:ayikie_users/src/models/images.dart';

class Search {
  int id;
  String name;
  String introduction;
  Images? image;
  String type;
  double price;

  Search(
      {required this.id,
      required this.price,
      required this.name,
      required this.introduction,
      this.image,
      required this.type});

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      id: json['id'],
      name: json['name'],
      introduction: json['introduction'] == null ? "" : json['introduction'],
      image: json['images'] != null
          ? Images.fromJson(json['images'])
          : Images(
              id: 1,
              imageName: "https://ayikie.cyberelysium.app/img/logo/logo.png"),
      type: json['type'],
      price: double.parse(json['price']),
    );
  }
}
