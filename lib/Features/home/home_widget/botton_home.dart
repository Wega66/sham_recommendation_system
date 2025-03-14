import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottonForHome extends StatelessWidget {
  const BottonForHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          alignment: Alignment.center,
          height: 34.h,
          width: 121.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), border: Border.all()),
          child: Text(
            'SEARCH BY IMAGE',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // لون الظل
                spreadRadius: 2, // مدى انتشار الظل
                blurRadius: 5, // مدى التمويه
                offset: Offset(0, 3), // موضع الظل
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
            onPressed: () {},
            child: Text(
              'ELECTRONIC SERVICES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        )
      ],
    );
  }
}
