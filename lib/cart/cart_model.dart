import 'package:meshop/product.dart';

class CartItem {
  final String id;
  final Product product;
  int quantity;

  CartItem({required this.id, required this.product, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      product: Product.fromJson(json['productId']),
      quantity: json['quantity'],
    );
  }
}
