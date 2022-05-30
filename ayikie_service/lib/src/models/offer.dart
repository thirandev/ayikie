import 'package:ayikie_service/src/models/user.dart';

class Offer {
  int id;
  int buyerRequestId;
  int duration;
  double price;
  String description;
  String createdAt;
  int status;
  User? user;

  Offer(
      {required this.id,
      required this.description,
      required this.buyerRequestId,
      required this.duration,
      required this.price,
      required this.status,
      required this.createdAt,
      this.user});

  @override
  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
        id: json['id'],
        buyerRequestId: json['buyer_request_id'],
        duration: json['duration'],
        price: json['price'],
        description: json['description'],
        createdAt: json['created_at'],
        status: json['status'],
        user: User.fromJson(json['seller']));
  }
}
