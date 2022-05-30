import 'package:ayikie_users/src/models/product.dart';

class CartItem {
  int cartItemId;
  int itemId;
  int customerId;
  int quantity;
  Product product;

  CartItem({
    required this.cartItemId,
    required this.itemId,
    required this.customerId,
    required this.quantity,
    required this.product,
  });

  @override
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json['id'],
      itemId: json['item_id'],
      quantity: json['quantity'],
      customerId: json['customer_id'],
      product: Product.fromJson(json['item']),
    );
  }
}
