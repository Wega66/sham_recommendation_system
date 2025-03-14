import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh, // استخدام screenutil لضبط الارتفاع بما يتناسب مع حجم الشاشة
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Center(
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/splash/second_image.png",
                  fit: BoxFit.fitWidth, // أو يمكنك تجربة BoxFit.cover
                  width: double
                      .infinity, // لضمان أن الصورة تأخذ العرض الكامل للشاشة
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
