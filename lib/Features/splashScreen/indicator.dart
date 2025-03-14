import 'package:flutter/material.dart';

import '../../core/themes/const.dart';

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:
          const Duration(milliseconds: 350), // مدة التغيير في الحجم واللون
      margin: const EdgeInsets.only(right: 5), // مسافة بين المؤشرات
      height: 6, // ارتفاع المؤشر
      width: isActive ? 20 : 8, // عرض المؤشر يعتمد على حالة isActive
      decoration: BoxDecoration(
        color: isActive
            ? kprimaryColor
            : const Color.fromARGB(
                255, 168, 212, 218), // تغيير اللون بناءً على isActive
        borderRadius: BorderRadius.circular(3), // زاوية مستديرة
      ),
    );
  }
}
