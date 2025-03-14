import 'package:flutter/material.dart';
import 'package:sahm/core/utils/colors.dart';


Widget buildCheckoutButton( BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: ElevatedButton(
        child: const Text(
          'CHECK OUT',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.success,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30), // Increase the border radius
          ),
        ),
        onPressed: () {
          // Handle checkout button press
          //Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen()));
        },
      ),
    );
  }
