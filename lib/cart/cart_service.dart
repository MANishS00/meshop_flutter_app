import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meshop/cart/cart_model.dart';
import 'package:meshop/services/user_session.dart';

class CartService {
  static const String baseUrl = "http://localhost:5000/api/cart";

  // Get cart
  static Future<List<CartItem>> getCart() async {
    final uid = await UserSession.getTempUserId();

    final res = await http.get(Uri.parse("$baseUrl?tempUserId=$uid"));

    final body = jsonDecode(res.body);
    return body.map<CartItem>((e) => CartItem.fromJson(e)).toList();
  }

  // Add to cart
  static Future<bool> addToCart(String productId) async {
    final uid = await UserSession.getTempUserId();

    final res = await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "productId": productId,
        "quantity": 1,
        "tempUserId": uid,
      }),
    );

    return res.statusCode == 200;
  }

  // Update quantity

  static Future<bool> updateQuantity(String cartId, int quantity) async {
    final res = await http.put(
      Uri.parse("$baseUrl/update/$cartId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"quantity": quantity}),
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
    final uid = await UserSession.getTempUserId();

    final res = await http.delete(Uri.parse("$baseUrl/clear/$uid"));
    return res.statusCode == 200;
  }
}
