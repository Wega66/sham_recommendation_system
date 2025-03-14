//!appBar
import 'package:flutter/material.dart';
import 'package:sahm/core/themes/app_bar_theme.dart';
import 'package:sahm/core/utils/sizes.dart';

AppBar appBare(Function()? onPressed, {required String parText}) {
  return AppBar(
    backgroundColor: TAppBarTheme.lightAppBarTheme.backgroundColor,
    surfaceTintColor: TAppBarTheme.lightAppBarTheme.surfaceTintColor,
    centerTitle: true,
    elevation: TAppBarTheme.lightAppBarTheme.elevation,
    toolbarHeight: TSizes.appbarHeight,
    title: Text(
      parText,
      style: TAppBarTheme.lightAppBarTheme.titleTextStyle,
    ),
    actions: [
      IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.search),
        color: TAppBarTheme.lightAppBarTheme.actionsIconTheme?.color,
        iconSize: TAppBarTheme.lightAppBarTheme.actionsIconTheme?.size,
      )
    ],
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.arrow_back_ios_new),
      color: TAppBarTheme.lightAppBarTheme.iconTheme?.color,
      iconSize: TAppBarTheme.lightAppBarTheme.iconTheme?.size,
    ),
  );
}
