import 'package:ayikie_users/src/models/service.dart';

class Order {
  int orderId;
  int customerId;
  int userId;
  int serviceId;
  double price;
  int duration;
  String note;
  String createdAt;
  int status;
  Service service;

  Order(
      {required this.orderId,
      required this.customerId,
      required this.userId,
      required this.serviceId,
      required this.price,
      required this.duration,
      required this.note,
      required this.createdAt,
      required this.status,
      required this.service});

  @override
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        orderId: json['id'],
        customerId: json['customer_id'],
        userId: json['user_id'],
        serviceId: json['service_id'],
        price: double.parse(json['price']),
        duration: json['duration'],
        note: json['note'] == null ? "" : json['note'],
        status: json['status'],
        createdAt: json['created_at'],
        service: Service.fromJson(json['service']));
  }
}
