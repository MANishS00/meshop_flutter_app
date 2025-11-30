import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meshop/product.dart';

class ApiService {
  static const String BASE_URL = "http://localhost:5000";

  // Get All Products
  static Future<List<Product>> getProducts() async {
    final url = Uri.parse("$BASE_URL/api/products/all");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((p) => Product.fromJson(p)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  // Upload Product (image + name)
  static Future<bool> uploadProduct(File image, String name) async {
    final url = Uri.parse("$BASE_URL/api/products/create");

    var request = http.MultipartRequest("POST", url);

    request.files.add(await http.MultipartFile.fromPath("image", image.path));

    request.fields["name"] = name;

    final response = await request.send();

    return response.statusCode == 200;
  }
}
