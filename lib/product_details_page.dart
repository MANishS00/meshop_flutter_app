import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meshop/cart/cart_service.dart';
import 'package:meshop/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE SLIDER
            CarouselSlider(
              options: CarouselOptions(height: 300, enlargeCenterPage: true),
              items: product.images.map((img) {
                return Builder(
                  builder: (context) {
                    return Image.network(
                      "https://ecommerce-app-ci4j.onrender.com$img",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                );
              }).toList(),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // PRICE
                  Row(
                    children: [
                      Text(
                        "₹${product.offerPrice}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "₹${product.totalPrice}",
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // RATING
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text(" ${product.rating}/5"),
                    ],
                  ),

                  SizedBox(height: 15),

                  // DESCRIPTION
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(product.description, style: TextStyle(fontSize: 16)),
                  ElevatedButton(
                    onPressed: () async {
                      bool ok = await CartService.addToCart(product.id);
                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added to cart!")),
                        );
                      }
                    },
                    child: Text("Add to Cart"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
