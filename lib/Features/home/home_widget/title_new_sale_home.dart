// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleHomeSaleORNew extends StatelessWidget {
  const TitleHomeSaleORNew({
    super.key,
    required this.title,
    required this.supTitle,
  });
  final String title;
  final String supTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 34.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              supTitle,
              style: TextStyle(
                color: Color(0xff9B9B9B),
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ShopingScreen(),
            //   ),
            // );
          },
          child: Text(
            'View all',
            style: TextStyle(
              color: Colors.black,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
