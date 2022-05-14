
import 'package:ayikie_service/src/models/product.dart';

class ProductOrder {
  int orderId;
  int customerId;
  int userId;
  int productId;
  double price;
  String createdAt;
  int status;
  Product product;

  ProductOrder(
      {required this.orderId,
        required this.customerId,
        required this.userId,
        required this.productId,
        required this.price,
        required this.createdAt,
        required this.status,
        required this.product});

  @override
  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
        orderId: json['id'],
        customerId: json['customer_id'],
        userId: json['user_id'],
        productId: json['product_order_id'],
        price: double.parse(json['total']),
        status: json['status'],
        createdAt: json['created_at'],
        product: Product.fromJson(json['item']));
  }
}
