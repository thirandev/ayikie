import 'package:ayikie_users/src/models/offer.dart';

class BuyerRequest {
  int id;
  int customerId;
  int categoryId;
  int subCategoryId;
  String location;
  String description;
  int duration;
  double price;
  int status;
  String createdAt;
  String title;
  List<Offer> offers;

  BuyerRequest(
      {required this.id,
      required this.title,
      required this.customerId,
      required this.categoryId,
      required this.subCategoryId,
      required this.location,
      required this.duration,
      required this.price,
      required this.status,
      required this.createdAt,
      required this.description,
        required this.offers});

  @override
  factory BuyerRequest.fromJson(Map<String, dynamic> json) {
    return BuyerRequest(
      id: json['id'],
      title: json['title'] == null ? "" : json['title'],
      customerId: json['customer_id'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      location: json['location'],
      duration: json['duration'],
      description: json['description'],
      price: double.parse(json['price']),
      status: json['status'],
      createdAt: json['created_at'],
      offers: (json['offers'] == null ? [] : json['offers'] as List)
          .map((i) => Offer.fromJson(i))
          .toList(),
    );
  }
}
