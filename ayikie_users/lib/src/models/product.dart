import 'package:ayikie_users/src/models/Item.dart';
import 'package:ayikie_users/src/models/comment.dart';
import 'package:ayikie_users/src/models/images.dart';

class Product extends Item {
  int customerId;
  int categoryId;
  int stock;
  int subCategoryId;
  String introduction;
  String location;
  double price;
  List<Comment>? comment;

  Product(
      {required int id,
        required this.customerId,
        required String name,
        required this.introduction,
        String? description,
        required this.categoryId,
        required this.subCategoryId,
        required this.location,
        required this.price,
        required this.stock,
        this.comment,
        Images? image})
      : super(id: id, name: name, description: description, image: image);

  @override
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      customerId: json['customer_id'],
      introduction: json['introduction'] == null ? "" : json['introduction'],
      description: json['description'] == null ? "" : json['description'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      location: json['location'] == null ? "" : json['location'],
      price: double.parse(json['price']),
      stock: json['stock'] == null ?0:json['stock'],
      image: Images.fromJson(json['images']),
      comment: (json['comments'] == null ? [] : json['comments'] as List)
          .map((i) => Comment.fromJson(i))
          .toList(),
    );
  }
}
