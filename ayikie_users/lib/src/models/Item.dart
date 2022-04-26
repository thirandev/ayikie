import 'package:ayikie_users/src/models/images.dart';
import 'package:ayikie_users/src/models/meta.dart';

class Item {
  int id;
  String name;
  String? description;
  Images? image;

  Item({required this.id, required this.name, this.description, this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'] == null ? "" : json['description'],
      image: json['images'] != null ? Images.fromJson(json['images']):Images(id: 1, imageName: "https://ayikie.cyberelysium.app/img/logo/logo.png"),
    );
  }
}
