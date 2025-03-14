//!appBar
// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sahm/core/themes/app_bar_theme.dart';
import 'package:sahm/core/utils/sizes.dart';

AppBar appBar(
    {required String parText,
    Function()? onPressed,
    void Function()? ShareOnPressed}) {
  return AppBar(
    backgroundColor: TAppBarTheme.lightAppBarTheme.backgroundColor,
    surfaceTintColor: TAppBarTheme.lightAppBarTheme.surfaceTintColor,
    centerTitle: true,
    elevation: TAppBarTheme.lightAppBarTheme.elevation,
    toolbarHeight: TSizes.appbarHeight,
    title: SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                parText,
                speed: Duration(milliseconds: 100),
              ),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      ),
    ).animate().fadeIn().scale().move(delay: 20.ms, duration: 600.ms),

    //  Text(
    //   parText,
    // style: TAppBarTheme.lightAppBarTheme.titleTextStyle,
    // ),
    actions: [
      IconButton(
        onPressed: ShareOnPressed,
        icon: Icon(Icons.share_outlined),
        color: TAppBarTheme.lightAppBarTheme.actionsIconTheme?.color,
        iconSize: TAppBarTheme.lightAppBarTheme.actionsIconTheme?.size,
      )
    ],
    leading: IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.close,
        color: Colors.red,
      ),
      color: TAppBarTheme.lightAppBarTheme.iconTheme?.color,
      iconSize: TAppBarTheme.lightAppBarTheme.iconTheme?.size,
    ),
  );
}
