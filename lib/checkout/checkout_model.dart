class CheckoutModel {
  String firstName;
  String? lastName;
  String mobile;
  String? secondaryMobile;
  String address1;
  String? address2;
  String street;
  String city;
  String state;
  String pincode;
  String? landmark;

  CheckoutModel({
    required this.firstName,
    this.lastName,
    required this.mobile,
    this.secondaryMobile,
    required this.address1,
    this.address2,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    this.landmark,
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "mobile": mobile,
    "secondaryMobile": secondaryMobile,
    "address1": address1,
    "address2": address2,
    "street": street,
    "city": city,
    "state": state,
    "pincode": pincode,
    "landmark": landmark,
  };
}
