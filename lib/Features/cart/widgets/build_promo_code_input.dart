import 'package:flutter/material.dart';

Widget buildPromoCodeInput() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: Container(
            //width: double.infinity,
            height: 40,
            child: const TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Enter your promo code',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
        Container(
          //padding: EdgeInsets.all(8),
          //margin: EdgeInsets.all(8),
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3),
                blurRadius: 5,
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
