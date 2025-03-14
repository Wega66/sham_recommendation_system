// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottonReviews extends StatelessWidget {
  const BottonReviews({
    super.key,
    required this.onPressedToCart,
  });
  final Function() onPressedToCart;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          alignment: Alignment.center,
          height: 34.h,
          width: 160.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), border: Border.all()),
          child: Text(
            'PREVIEW 3D',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        )
            .animate()
            .fadeIn() // uses `Animate.defaultDuration`
            .scale() // inherits duration from fadeIn
            .move(delay: 20.ms, duration: 600.ms),
        Container(
          width: 160.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // لون الظل
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: onPressedToCart,
            child: Text(
              'ADD TO CART',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        )
            .animate()
            .fadeIn() // uses `Animate.defaultDuration`
            .scale() // inherits duration from fadeIn
            .move(
              delay: 20.ms,
              duration: 600.ms,
            ),
      ],
    );
  }
}
