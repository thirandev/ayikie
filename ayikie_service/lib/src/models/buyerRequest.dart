import 'package:ayikie_service/src/models/user.dart';

class BuyerRequest {
  int id;
  int customerId;
  String description;
  String location;
  String title;
  int duration;
  double price;
  int status;
  String createdAt;
  User user;

  BuyerRequest(
      {required this.id,
      required this.customerId,
      required this.title,
      required this.location,
      required this.duration,
      required this.description,
      required this.price,
      required this.status,
      required this.createdAt,
      required this.user});

  @override
  factory BuyerRequest.fromJson(Map<String, dynamic> json) {
    return BuyerRequest(
      id: json['id'],
      customerId: json['customer_id'],
      title: json['title'],
      description:json['description'],
      location: json['location'],
      duration: json['duration'],
      price: json['price'],
      status: json['status'],
      createdAt: json['created_at'],
      user: User.fromJson(json['customer']),
    );
  }
}
