import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meshop/checkout/checkout_model.dart';

class CheckoutService {
  static const String baseUrl = "http://localhost:5000/api/checkout/save";

  static Future<Map<String, dynamic>> createCheckout(CheckoutModel data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data.toJson()),
    );

    return jsonDecode(response.body);
  }
}
