import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/themes/const.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200.h,
      child: Stack(
        children: [
          // الخلفية مع شعار التطبيق
          Container(
            height: 0.30.sh,
            decoration: const BoxDecoration(
              color: kBackgroundColor,
              image: DecorationImage(
                image: AssetImage("assets/images/splash/logo.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // الصورة في الوسط
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35, // تعديل موضع الصورة
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/images/splash/first_image.jpeg",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
