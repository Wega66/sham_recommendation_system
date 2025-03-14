import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'first_splash.dart';
import 'splash_2.dart';
import 'splash_3.dart';
import 'indicator.dart';

class SplashOneScreen extends StatefulWidget {
  const SplashOneScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<SplashOneScreen> createState() => _SplashOneScreenState();
}

class _SplashOneScreenState extends State<SplashOneScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Soug Sahm".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TabBar المخفي (لتغيير التبويبات بشكل غير مباشر)
          SizedBox(
            height: 1.h, // استخدام ScreenUtil لضبط الارتفاع
            child: TabBar(
              controller: controller,
              isScrollable: true,
              tabs: List.generate(
                3,
                (index) => Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //! TabBarView لعرض محتوى Splash Screens
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                FirstSplashScreen(),
                SecondSplashScreen(),
                ThirdSplashScreen(),
              ],
            ),
          ),

          // المؤشرات (Indicators) بناءً على التبويب الحالي
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3, // عدد التبويبات
              (index) => Indicator(
                isActive: controller.index == index, // تحديد المؤشر النشط
              ),
            ),
          ),
        ],
      ),
    );
  }
}
