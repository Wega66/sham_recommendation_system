// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth/login.dart';

class ThirdSplashScreen extends StatelessWidget {
  const ThirdSplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh, // استخدام ScreenUtil لضبط الارتفاع بما يتناسب مع الشاشة
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h), // ضبط الحافة السفلية
            height: 1.sh, // الارتفاع باستخدام ScreenUtil
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(30.r), // ضبط الزوايا المستديرة
            ),
            child: Image.asset(
              "assets/images/splash/img.png",
              fit: BoxFit
                  .cover, // لضبط الصورة لتغطي الحاوية بالكامل مع الحفاظ على نسبة الأبعاد
              width: double.infinity, // عرض الصورة لتغطي الشاشة بالكامل
            ),
          ),
          Positioned(
            top: 370.h, // ضبط المكان باستخدام ScreenUtil
            left: 16.w, // ضبط الحافة اليسرى باستخدام ScreenUtil
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => LoginScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(20.r), // الزوايا المستديرة
                  border: Border.all(), // إضافة الحدود حول الزر
                ),
                height: 40.h, // ضبط ارتفاع الزر
                width: 310.w, // ضبط عرض الزر باستخدام ScreenUtil
                child: Center(
                  child: Text(
                    "Get Start",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp, // ضبط حجم الخط باستخدام ScreenUtil
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
