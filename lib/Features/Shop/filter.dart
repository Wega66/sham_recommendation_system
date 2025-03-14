// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahm/core/themes/const.dart';
import 'package:sahm/core/themes/text_theme.dart';
import 'package:sahm/core/utils/sizes.dart';

class Filter extends StatefulWidget {
  // final String user, profileImage;
  // final List<String> brands;

  const Filter({
    super.key,
  });

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> selectedBrands = [];
  double price1 = 0.0, price2 = 0.0;

  List<Color> color = [
    Colors.red,
    Colors.pink,
    Colors.yellow,
    Colors.black,
    Colors.white70,
    Colors.blue
  ];

  List<String> colors = ["red", "pink", "yellow", "black", "white", "blue"];
  List<String> sizes = ["M", "XS", "S", "L", "XXL", "XXXl"];
  List<String> selectedColors = [];
  List<String> selectedSizes = [];
  List<String> selectedCategories = [];

  // @override
  // void initState() {
  //   selectedBrands = widget.brands;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Filters")),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: TSizes.spaceBtwSection),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: TSizes.spaceBtwSection),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Price range",
                      style: TTextTheme.lightTextThem.headlineSmall,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Container(
                    color: Colors.white,
                    width: width,
                    height: 60.h,
                    child: RangeSlider(
                      activeColor: Colors.red,
                      inactiveColor: Colors.grey,
                      values: RangeValues(price1, price2),
                      min: 0,
                      max: 100,
                      labels: RangeLabels(
                          price1.round().toString(), price2.round().toString()),
                      onChanged: (value) {
                        setState(() {
                          price1 = value.start;
                          price2 = value.end;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Colors",
                      style: TTextTheme.lightTextThem.headlineSmall,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Container(
                    color: Colors.grey,
                    width: width,
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: color.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedColors.contains(colors[index])) {
                                  selectedColors.remove(colors[index]);
                                } else {
                                  selectedColors.add(colors[index]);
                                }
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      style:
                                          selectedColors.contains(colors[index])
                                              ? BorderStyle.solid
                                              : BorderStyle.none,
                                      color: color[index],
                                      width: 2,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.5,
                                  left: 5,
                                  bottom: 25,
                                  right: 5,
                                  child: CircleAvatar(
                                    radius: 18.sp,
                                    backgroundColor: color[index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 29),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sizes",
                      style: TTextTheme.lightTextThem.headlineSmall,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Container(
                    color: Colors.white,
                    width: width,
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sizes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedSizes.contains(sizes[index])) {
                                  selectedSizes.remove(sizes[index]);
                                } else {
                                  selectedSizes.add(sizes[index]);
                                }
                              });
                            },
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          selectedSizes.contains(sizes[index])
                                              ? Colors.green
                                              : Colors.white,
                                    ),
                                    child: Center(child: Text(sizes[index])),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          height: 60,
          width: 330,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                width: 120,
                height: 50,
                child: Center(
                  child: Text(
                    "Discard",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Action when "Apply" is tapped
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: 120,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
