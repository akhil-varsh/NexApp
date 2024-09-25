

import 'package:flutter/material.dart';
// Ensure this import is correct
import 'package:nexmart/models/product.dart';

import '../models/cart.dart'; // Ensure this import is correct

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = []; // List to hold cart items

  // Getter for cart items
  List<CartItem> get cartItems => _cartItems;

  // Method to add item to cart
  void addItemToCart(Product product) {
    final index = _cartItems.indexWhere((item) => item?.product.id == product.id);

    if (index >= 0) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product)); // Create new CartItem if not found
    }
    notifyListeners(); // Notify listeners about the change
  }

  // Method to remove item from cart
  void removeItemFromCart(Product product) {
    _cartItems.removeWhere((item) => item?.product.id == product.id);
    notifyListeners();
  }

  // Method to update quantity of item
  void updateQuantity(Product product, int quantity) {
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (index >= 0 && quantity > 0) {
      _cartItems[index].quantity = quantity;
    }
    notifyListeners();
  }

  // Getter for total price
  double get totalPrice {
    return _cartItems.fold(
        0.0, (sum, item) => sum + item.product.price * item.quantity);
  }
}

// import 'package:flutter/material.dart';
// import 'package:nexmart/models/cart.dart';
// import 'package:nexmart/models/product.dart';
//
