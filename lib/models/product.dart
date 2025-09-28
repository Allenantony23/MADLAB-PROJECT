class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final double discount;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final String category;
  final List<String> tags;
  final bool isBestSeller;
  final bool isMadeInIndia;
  final bool inStock;
  final Map<String, dynamic>? specifications;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.category,
    required this.tags,
    this.isBestSeller = false,
    this.isMadeInIndia = false,
    this.inStock = true,
    this.specifications,
  });

  String get formattedPrice => '₹${price.toStringAsFixed(2)}';
  String get formattedOriginalPrice => '₹${originalPrice.toStringAsFixed(2)}';
}

class ProductReview {
  final String id;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;
  final bool verifiedPurchase;

  ProductReview({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
    this.verifiedPurchase = false,
  });
}