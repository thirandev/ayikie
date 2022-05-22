
import 'package:ayikie_service/src/models/orderItem.dart';
import 'package:ayikie_service/src/models/product.dart';

class ProductOrder {
  int orderId;
  int customerId;
  int userId;
  int productId;
  double price;
  String createdAt;
  String? trackingNo;
  int status;
  Product product;
  OrderItem orderItem;

  ProductOrder(
      {required this.orderId,
        required this.customerId,
        required this.userId,
        required this.productId,
        required this.price,
        required this.createdAt,
        required this.status,
        required this.orderItem,
        this.trackingNo,
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
        trackingNo: json['tracking_no'],
        orderItem: OrderItem.fromJson(json['order']),
        product: Product.fromJson(json['item']));
  }
}
