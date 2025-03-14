import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahm/Features/details_screen/view/details_screen.dart';

class ListViewImages extends StatelessWidget {
  const ListViewImages({
    super.key,
    required this.prod,
  });

  final DetailsScreen prod;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: prod.product.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Image.network(
              prod.product.images[index],
              fit: BoxFit.cover,
            )
                .animate()
                .fadeIn() // uses `Animate.defaultDuration`
                .scale() // inherits duration from fadeIn
                .move(delay: 20.ms, duration: 600.ms),
          );
        },
      ),
    );
  }
}
