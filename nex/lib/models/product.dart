class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  final Map<String, dynamic> rating; // Rating is an object in the response

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      imageUrl: json['image'],
      rating: json['rating'], // This should be the entire rating object
    );
  }
}
