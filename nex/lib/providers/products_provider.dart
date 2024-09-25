import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
 // Make sure to import your Product class

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts([String query = '']) async {
    const url = 'https://fakestoreapi.com/products'; // Replace with your actual API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> productData = json.decode(response.body);
      _products = productData.map((json) => Product.fromJson(json)).toList();

      // Filter products based on the search query if it's not empty
      if (query.isNotEmpty) {
        _products = _products.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }

      notifyListeners(); // Notify listeners of changes
    } else {
      throw Exception('Failed to load products');
    }
  }
}
