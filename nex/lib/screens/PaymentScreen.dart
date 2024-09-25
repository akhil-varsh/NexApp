import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod; // Variable to track selected payment method
  final TextEditingController _upiController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Options',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a payment method:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Cash Payment Option with Icon
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.money, color: Colors.green), // Cash Icon
                  SizedBox(width: 8), // Space between icon and text
                  Text(
                    'Cash',
                    style: TextStyle(fontWeight: FontWeight.bold), // Bold font
                  ),
                ],
              ),
              leading: Radio<String>(
                value: 'Cash',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value; // Update selected method
                  });
                },
              ),
            ),

            // Card Payment Option with Icon
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.credit_card, color: Colors.blue), // Card Icon
                  SizedBox(width: 8), // Space between icon and text
                  Text(
                    'Card',
                    style: TextStyle(fontWeight: FontWeight.bold), // Bold font
                  ),
                ],
              ),
              leading: Radio<String>(
                value: 'Card',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value; // Update selected method
                  });
                },
              ),
            ),
            // Card Details TextField
            if (_selectedPaymentMethod == 'Card') ...[
              Padding(
                padding: const EdgeInsets.only(left: 56.0), // Indent to match radio button
                child: TextField(
                  controller: _cardNumberController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberTextInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Enter Card Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 10),
            ],

            // UPI Payment Option with Icon
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.payment, color: Colors.purple), // UPI Icon
                  SizedBox(width: 8), // Space between icon and text
                  Text(
                    'UPI',
                    style: TextStyle(fontWeight: FontWeight.bold), // Bold font
                  ),
                ],
              ),
              leading: Radio<String>(
                value: 'UPI',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value; // Update selected method
                  });
                },
              ),
            ),
            // UPI Details TextField
            if (_selectedPaymentMethod == 'UPI') ...[
              Padding(
                padding: const EdgeInsets.only(left: 56.0), // Indent to match radio button
                child: TextField(
                  controller: _upiController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your VPA (e.g., example@upi)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 10),
            ],
          ],
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
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order placed successfully!')),
                );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Text(
                  'Order Now',
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ), // Adjust font size and weight
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


// Custom TextInputFormatter for formatting card number
class CardNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to 12 digits
    if (digitsOnly.length > 12) {
      digitsOnly = digitsOnly.substring(0, 12);
    }

    // Format as 4 digit groups separated by hyphens
    StringBuffer formatted = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted.write('-');
      }
      formatted.write(digitsOnly[i]);
    }

    // Return the formatted text
    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
