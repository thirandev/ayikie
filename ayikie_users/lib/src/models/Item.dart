import 'package:ayikie_users/src/models/images.dart';

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
      image: json['images'] != null ? Images.fromJson(json['images']):Images(id: 1, imageName: "89b1e72d4027670d20c73440d5da3041.jpg"),
    );
  }
}
