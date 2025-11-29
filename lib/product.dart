class Product {
  final String id;
  final List<String> images;
  final String name;
  final String description;
  final double totalPrice;
  final double offerPrice;
  final double rating;

  Product({
    required this.id,
    required this.images,
    required this.name,
    required this.description,
    required this.totalPrice,
    required this.offerPrice,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      images: List<String>.from(json['images']),
      name: json['name'],
      description: json['description'],
      totalPrice: json['totalPrice'].toDouble(),
      offerPrice: json['offerPrice'].toDouble(),
      rating: json['rating'].toDouble(),
    );
  }
}
