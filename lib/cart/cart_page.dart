import 'package:flutter/material.dart';
import 'package:meshop/cart/cart_model.dart';
import 'package:meshop/cart/cart_service.dart';
import 'package:meshop/checkout/checkout_screen.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cart = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  Future fetchCart() async {
    final data = await CartService.getCart();
    setState(() {
      cart = data;
      loading = false;
    });
  }

  double get totalPrice {
    double total = 0;

    for (var item in cart) {
      total += item.product.offerPrice * item.quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        actions: [
          TextButton(
            onPressed: () async {
              await CartService.clearCart();
              fetchCart();
            },
            child: Text("Clear All", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : cart.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      var item = cart[index];

                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.network(
                            item.product.images[0],
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.product.name),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("₹${item.product.offerPrice}"),

                              Row(
                                children: [
                                  // MINUS BUTTON
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      if (item.quantity > 1) {
                                        await CartService.updateQuantity(
                                          item.id,
                                          item.quantity - 1,
                                        );
                                        fetchCart();
                                      }
                                    },
                                  ),

                                  // QUANTITY
                                  Text(
                                    item.quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // PLUS BUTTON
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Colors.green,
                                    ),
                                    onPressed: () async {
                                      if (item.quantity < 5) {
                                        await CartService.updateQuantity(
                                          item.id,
                                          item.quantity + 1,
                                        );
                                        fetchCart();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await CartService.removeItem(item.id);
                              fetchCart();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Total
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Total: ₹$totalPrice",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(),
                            ),
                          );
                        },
                        child: Text("Proceed to Checkout"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
