import 'package:flutter/material.dart';
import 'package:nexmart/main.dart';
import 'PaymentScreen.dart';
import 'package:nexmart/providers/cart_provider.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFFE1BEE7),
          ),
        ),
        actions: [
          ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (ctx, cartProvider, child) => cartProvider.cartItems.isEmpty
            ? Center(child: Text('Your cart is empty.'))
            : ListView.builder(
          itemCount: cartProvider.cartItems.length,
          itemBuilder: (ctx, index) {
            final cartItem = cartProvider.cartItems[index];
            return Card(
              margin: const EdgeInsets.all(10.0), // Add padding to items
              elevation: 5,
              child:ListTile(
                leading: Container(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: ClipOval( // Optional: Make the image circular
                    child: Image.network(
                      cartItem.product.imageUrl,
                      fit: BoxFit.cover, // Ensure the image covers the entire area
                    ),
                  ),
                ),
                title: Text(
                  cartItem.product.title,
                  style: TextStyle(fontSize: 14), // Reduced font size for the title
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the left
                  children: [
                    Text(
                      'Quantity: ${cartItem.quantity}',
                      style: TextStyle(fontSize: 12), // Reduced font size for the subtitle
                    ),
                    // Row for Price and Delete Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between price and icon
                      children: [
                        Text(
                          '\₹${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16, // Increased font size for the price
                            fontWeight: FontWeight.bold, // Make the price bold
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false).removeItemFromCart(cartItem.product);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )

            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (ctx, cartProvider, child) {
          return Container(
            padding: EdgeInsets.all(16.0), // Add padding around the button
            child: SizedBox(
              height: 70, // Set height for the button area
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Text(
                  'Checkout: \₹${cartProvider.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white), // Adjust font size and weight
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}