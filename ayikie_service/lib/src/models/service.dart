import 'dart:ffi';

import 'package:ayikie_service/src/models/Item.dart';
import 'package:ayikie_service/src/models/comment.dart';
import 'package:ayikie_service/src/models/images.dart';

class Service extends Item {
  int customerId;
  int categoryId;
  int subCategoryId;
  String introduction;
  String location;
  String state;
  double price;
  List<Comment>? comment;

  Service(
      {required int id,
      required this.customerId,
      required String name,
      required this.introduction,
      String? description,
      required this.categoryId,
      required this.subCategoryId,
      required this.location,
      required this.state,
      required this.price,
      this.comment,
      Images? image})
      : super(id: id, name: name, description: description, image: image);

  @override
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      customerId: json['customer_id'],
      introduction: json['introduction'] == null ? "" : json['introduction'],
      description: json['description'] == null ? "" : json['description'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      location: json['location'] == null ? "" : json['location'],
      state: json['state'] == null ? "" : json['state'],
      price: double.parse(json['price']),
      image: Images.fromJson(json['images']),
      comment: (json['comments'] == null ? [] : json['comments'] as List)
          .map((i) => Comment.fromJson(i))
          .toList(),
    );
  }
}
