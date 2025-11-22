class Product {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final int rating;
  final int totalPrice;
  final int offerPrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.rating,
    required this.totalPrice,
    required this.offerPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // SAFE images handling
    List<String> imgs = [];

    // If images list exists
    if (json["images"] != null && json["images"] is List) {
      imgs = List<String>.from(json["images"]);
    }

    // If a single image exists
    if (json["image"] != null &&
        json["image"] is String &&
        json["image"] != "") {
      String imgPath = json["image"].toString();

      // ensure only one slash
      if (!imgPath.startsWith("/")) {
        imgPath = "/$imgPath";
      }

      imgs.add(imgPath);
    }

    // Clean all paths
    imgs = imgs.map((p) => p.replaceAll("//", "/")).toList();

    // If still empty → add a placeholder image
    if (imgs.isEmpty) {
      imgs.add("uploads/no-image.png");
    }

    return Product(
      id: json["_id"] ?? "",
      name: json["name"] ?? "No Name",
      description: json["description"] ?? "No description available",
      images: imgs,
      rating: json["rating"] ?? 0,
      totalPrice: json["totalPrice"] ?? 0,
      offerPrice: json["offerPrice"] ?? 0,
    );
  }
}
