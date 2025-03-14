// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sahm/Features/search/details_search.dart';

import 'package:sahm/controller/shop_home/sahm_cubit.dart';
import 'package:sahm/core/models/product_model.dart';
import 'package:sahm/core/shared/shared_prefrances.dart';
import 'package:sahm/core/themes/text_theme.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("data");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<SahmCubit, SahmState>(
      builder: (context, state) {
        if (state is SahmLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SahmError) {
          return Center(
            child: SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 60.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Canterbury',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ScaleAnimatedText('No'),
                    ScaleAnimatedText(state.error),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
          );
        } else if (state is SuccessGetProduct) {
          //! List of Product model
          final products = state.products;
          //! List of Filter products
          List<Product> filterProducts = products.where((element) {
            return element.category.name.contains(query);
          }).toList();

          if (query == "" ? products.isNotEmpty : filterProducts.isNotEmpty) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                SharedPreferencesHelper.getBool(
                  'favorite',
                );
                context.read<SahmCubit>().getProduct();
                return Future.delayed(Duration(seconds: 4));
              },
              displacement: 50,
              color: Colors.blueAccent,
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.w,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    mainAxisExtent: 380,
                  ),
                  itemCount:
                      query == "" ? products.length : filterProducts.length,
                  itemBuilder: (context, index) {
                    return cardProduct(
                        query == "" ? products : filterProducts, index);
                  },
                ),
              ),
            );
          } else {
            //! Animation text
            return Center(
                child: Padding(
              padding: EdgeInsets.all(10.h),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      "No '$query'",
                      speed: Duration(milliseconds: 250),
                    ),
                    // WavyAnimatedText('Look at the waves'),
                  ],
                  repeatForever: true,
                  isRepeatingAnimation: true,
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              )
                  .animate()
                  .fadeIn() // uses `Animate.defaultDuration`
                  .scale() // inherits duration from fadeIn
                  .move(delay: 20.ms, duration: 600.ms),
            ));
          }
        } else {
          return Center(child: Text('No InterNet'));
        }
      },
    )
        .animate()
        .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
        .scale(duration: 600.ms, curve: Curves.easeOutBack)
        .move(
          begin: Offset(0, -20),
          delay: 100.ms,
          duration: 600.ms,
          curve: Curves.easeInOut,
        )
        .then();
  }
}

InkWell cardProduct(List<Product> products, int index) {
  return InkWell(
    //! When the card is tapped, this function is executed
    onTap: () {
      Get.to(() => DetailsSearch(
            product: products[index],
          ));
    },
    //! SizedBox defines a box with a specific height
    child: SizedBox(
      height: 380,
      //! Stack allows layering widgets on top of each other
      child: Stack(
        children: [
          //! SizedBox is used to constrain the width of the child widget
          SizedBox(
            width: 182.w,
            //! Card widget creates a material design card
            child: Card(
              color: Colors.white,
              //! Defines the shape of the card
              shape: RoundedRectangleBorder(),
              //! Column arranges widgets vertically
              child: Column(
                children: [
                  //! Container is used to hold and style the image
                  Container(
                    height: 184.h,
                    //! BoxDecoration is used for the background image
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(products[index].imageCover),
                        //! fit ensures the image covers the entire area
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      //! Animation for fading in and scaling the image
                      .animate()
                      .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
                      .scale(duration: 600.ms, curve: Curves.easeOutBack)
                      //! Moves the image slightly upwards with animation
                      .move(
                        begin: Offset(0, -20),
                        delay: 100.ms,
                        duration: 600.ms,
                        curve: Curves.easeInOut,
                      )
                      .then(),
                  //! Padding adds space around its child widget
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    //! Another Column for text content and rating
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! Padding for spacing at the top and left of the rating row
                        Padding(
                          padding: const EdgeInsets.only(top: 25, left: 8),
                          //! Row arranges widgets horizontally
                          child: Row(
                            children: [
                              //! Displays the product's star rating
                              _getStarRating(
                                  products[index].ratingsQuantity.toDouble()),
                              //! Displays the number of ratings next to the stars
                              Text("(${products[index].ratingsQuantity})"),
                            ],
                          ),
                        ),
                        //! Padding for spacing around the product title
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          //! Text widget to display the product's title
                          child: Text(
                            products[index].title,
                            style: TTextTheme.lightTextThem.labelMedium,
                            maxLines: 1,
                            //! Ellipsis if the text overflows
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //! Padding for spacing around the product category
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          //! Text widget to display the product's category
                          child: Text(
                            products[index].category.name,
                            style: TTextTheme.lightTextThem.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //! Conditional widget to display discounted price if the product is trending
                        products[index].trending
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                //! Row for original and discounted prices
                                child: Row(
                                  children: [
                                    //! Text widget to display the original price with a strikethrough
                                    Text(
                                      "${products[index].price}\$",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    )
                                        .animate()
                                        .fadeIn(
                                            duration: 800.ms,
                                            curve: Curves.easeInOut)
                                        .scale(
                                            duration: 600.ms,
                                            curve: Curves.easeOutBack)
                                        .move(
                                          begin: Offset(0, -20),
                                          delay: 100.ms,
                                          duration: 600.ms,
                                          curve: Curves.easeInOut,
                                        )
                                        .then()
                                        //! Shake animation to emphasize the discounted price
                                        .shake(
                                          delay: 500.ms,
                                          hz: 4,
                                          curve: Curves.elasticOut,
                                        ),
                                    //! SizedBox for spacing between the original and discounted price
                                    SizedBox(width: 5.w),
                                    //! Text widget for the discounted price
                                    Text(
                                      "${products[index].priceAfterDiscount}\$",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            //! If not trending, show only the discounted price
                            : Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Text(
                                  "${products[index].priceAfterDiscount}\$",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //! Positioned allows placing widgets at specific positions within the Stack
          Positioned(
            top: 10.h,
            left: 10.w,
            //! If the product is trending, show a discount badge
            child: products[index].trending
                ? Container(
                    alignment: Alignment.center,
                    height: 24.h,
                    width: 40.w,
                    //! Decoration for the discount badge
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    //! Text displaying the discount percentage
                    child: Text(
                      "-${calculateDiscount(products[index].price.toInt(), products[index].priceAfterDiscount.toInt())}%",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          //! Positioned widget for the favorite button at the bottom of the card
        ],
      ),
    ),
  );
}

//! Widget for the star rating display
Widget _getStarRating(double rating) {
  return RatingBar.builder(
    //! Disables the ability to change the rating by touch
    ignoreGestures: true,
    itemSize: 15,
    //! Sets the initial rating
    initialRating: rating,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    //! Padding between each star
    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
    //! Icon for each star
    itemBuilder: (context, _) => const Icon(
      Icons.star,
      color: Colors.amber,
    ),
    //! No action on rating update since it's static
    onRatingUpdate: (rating) {},
  );
}

//! The function for calculating the discount percentage
int calculateDiscount(int price, int priceAfterDiscount) {
  return ((price - priceAfterDiscount) / price * 100).round();
}
