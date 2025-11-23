import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meshop/cart/cart_model.dart';

class CartService {
  static const String baseUrl = "http://localhost:5000/api/cart";

  // Get cart
  static Future<List<CartItem>> getCart() async {
    final res = await http.get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      final body = json.decode(res.body) as List;

      return body.map((e) => CartItem.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load cart");
    }
  }

  // Add to cart
  static Future<bool> addToCart(String productId) async {
    final res = await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"productId": productId, "quantity": 1}),
    );

    return res.statusCode == 200;
  }

  // Remove item
  static Future<bool> removeItem(String cartId) async {
    final res = await http.delete(Uri.parse("$baseUrl/$cartId"));

    return res.statusCode == 200;
  }

  // Clear entire cart
  static Future<bool> clearCart() async {
    final res = await http.delete(Uri.parse(baseUrl));

    return res.statusCode == 200;
  }
}
