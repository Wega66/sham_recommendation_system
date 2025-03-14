// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahm/core/themes/app_bar_theme.dart';
import 'package:sahm/core/themes/const.dart';
import 'package:sahm/core/themes/text_field_theme.dart';
import 'package:sahm/core/utils/colors.dart';
import 'package:sahm/core/utils/sizes.dart';

class BrandsScreen extends StatefulWidget {
  BrandsScreen({
    super.key,
  });

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  List<String> brandList = [
    "adidas",
    "adidas Original",
    "Blend",
    "Boutique Moschino",
    "Champion",
    "Diesel",
    "jack & Jones",
    "Naf Naf ",
    "Red Valentino",
    "s.Oliver"
  ];
  List<bool> componentItemsChecked = [];
  List<String> selectedComponent = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < brandList.length; i++) {
      componentItemsChecked.add(false);
    }
  }

  getAppBar(String pageTitle) {
    return AppBar(
      backgroundColor: TAppBarTheme.lightAppBarTheme.backgroundColor,
      surfaceTintColor: TAppBarTheme.lightAppBarTheme.surfaceTintColor,
      centerTitle: TAppBarTheme.lightAppBarTheme.centerTitle,
      elevation: TAppBarTheme.lightAppBarTheme.elevation,
      toolbarHeight: TSizes.appbarHeight,
      title: Text(
        pageTitle,
        style: TAppBarTheme.lightAppBarTheme.titleTextStyle,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: TAppBarTheme.lightAppBarTheme.actionsIconTheme?.color,
          iconSize: TAppBarTheme.lightAppBarTheme.actionsIconTheme?.size,
        )
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new),
        color: TAppBarTheme.lightAppBarTheme.iconTheme?.color,
        iconSize: TAppBarTheme.lightAppBarTheme.iconTheme?.size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: TColors.lightGrey,
      appBar: getAppBar("Brands"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: TSizes.spaceBtwSection,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: width,
              decoration: BoxDecoration(
                color: TColors.borderPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelStyle:
                      TTextFieldTheme.lightInputDecorationTheme.labelStyle,
                  hintStyle:
                      TTextFieldTheme.lightInputDecorationTheme.hintStyle,
                  floatingLabelStyle: TTextFieldTheme
                      .lightInputDecorationTheme.floatingLabelStyle,
                  border: TTextFieldTheme.lightInputDecorationTheme.border,
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor:
                      TTextFieldTheme.lightInputDecorationTheme.prefixIconColor,
                  enabledBorder:
                      TTextFieldTheme.lightInputDecorationTheme.enabledBorder,
                  focusedBorder:
                      TTextFieldTheme.lightInputDecorationTheme.focusedBorder,
                  hintText: "Search",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: brandList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 1 / 30,
                      right: MediaQuery.of(context).size.height * 1 / 30,
                      top: MediaQuery.of(context).size.height * 1 / 310),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120.w,
                        child: Text(
                          brandList[index],
                          style: TextStyle(
                              color: (componentItemsChecked[index])
                                  ? kprimaryColor
                                  : Colors.black),
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: (componentItemsChecked[index] == true)
                            ? kprimaryColor
                            : Colors.white,
                        value: componentItemsChecked[index],
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        onChanged: (bool? value) {
                          setState(() {
                            componentItemsChecked[index] = value!;
                            if (value) {
                              selectedComponent.add(brandList[index]);
                            } else {
                              selectedComponent.remove(brandList[index]);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedComponent = [];
                    });
                  },
                  child: Text("Discard"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CatalogScreen(
                    //       user: widget.user,
                    //       profileImage: widget.profileImage,
                    //     ),
                    //   ),
                    //);
                  },
                  child: Text("Apply"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
