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
      image: Images.fromJson(json['images']),
    );
  }
}
