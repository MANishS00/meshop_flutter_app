import 'package:flutter/material.dart';
import 'package:meshop/checkout/checkout_model.dart';
import 'package:meshop/checkout/checkout_service.dart';
import 'package:meshop/payment/PaymentScreen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final mobile = TextEditingController();
  final secondaryMobile = TextEditingController();
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final stateC = TextEditingController();
  final pincode = TextEditingController();
  final landmark = TextEditingController();

  bool isLoading = false;

  Future<void> submitCheckout() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    CheckoutModel checkoutData = CheckoutModel(
      firstName: firstName.text,
      lastName: lastName.text,
      mobile: mobile.text,
      secondaryMobile: secondaryMobile.text,
      address1: address1.text,
      address2: address2.text,
      street: street.text,
      city: city.text,
      state: stateC.text,
      pincode: pincode.text,
      landmark: landmark.text,
    );

    final result = await CheckoutService.createCheckout(checkoutData);

    setState(() => isLoading = false);

    print("API Response: $result"); // 🔥 DEBUG THIS
    Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen()));
    if (result["success"] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PaymentScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Something went wrong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Mandatory Fields
              TextFormField(
                controller: firstName,
                decoration: InputDecoration(labelText: "firstName *"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: mobile,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Mobile Number *"),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Required";
                  if (v.length != 10) return "Enter valid 10-digit mobile";
                  return null;
                },
              ),
              TextFormField(
                controller: address1,
                decoration: InputDecoration(labelText: "Address 1 *"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: street,
                decoration: InputDecoration(labelText: "Street *"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: city,
                decoration: InputDecoration(labelText: "City *"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: stateC,
                decoration: InputDecoration(labelText: "State *"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: pincode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Pincode *"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              SizedBox(height: 20),

              // Optional Fields
              TextFormField(
                controller: lastName,
                decoration: InputDecoration(labelText: "Last Name (Optional)"),
              ),
              TextFormField(
                controller: address2,
                decoration: InputDecoration(labelText: "Address 2 (Optional)"),
              ),
              TextFormField(
                controller: landmark,
                decoration: InputDecoration(labelText: "Landmark (Optional)"),
              ),
              TextFormField(
                controller: secondaryMobile,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Secondary Mobile (Optional)",
                ),
              ),

              SizedBox(height: 30),

              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: submitCheckout,
                      child: Text("Proceed to Checkout"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
