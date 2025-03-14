import 'package:flutter/material.dart';
import 'package:sahm/Features/botton_nav/bottom.dart';

class HomeNave extends StatelessWidget {
  const HomeNave({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        child: BottomNabigation(
          initialIndex: 0,
        ),
      ),
    );
  }
}
