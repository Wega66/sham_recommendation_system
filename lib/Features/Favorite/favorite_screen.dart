// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sahm/controller/Favorite/favorite_cubit.dart';
import 'package:sahm/core/models/product_model.dart';
import 'package:sahm/core/themes/text_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahm/widgets/appBar/app_Bar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  remove() {}

  //! This is where we initialize the screen and load favorite products using the FavoriteCubit
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().getFavoriteProduct();
  }

  //! This builds the entire screen layout with AppBar and SafeArea that wraps the body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBare(() {},
          parText:
              'Women’s tops'), //! Custom AppBar widget that shows the title
      body: SafeArea(
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          //! Listens to the state of the FavoriteCubit and reacts accordingly (loading, success, or error)
          builder: (context, state) {
            if (state is FavoriteLoading) {
              //! Displays loading indicator when data is being fetched
              return Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.inkDrop(
                    size: 50,
                    color: Colors.red,
                  ),
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
                    .then(),
              );
            } else if (state is FavoriteError) {
              //! Displays an error message if something went wrong during fetching
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
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
                            ScaleAnimatedText('     No'),
                            ScaleAnimatedText(state.error),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Icon(
                    Icons.wifi_off,
                    size: 60,
                  ),
                ],
              );
            } else if (state is FavoriteSuccess) {
              //! Displays the favorite products in a grid if the data is fetched successfully
              final favProducts = state.favoriteProduct;

              if (favProducts.isNotEmpty) {
                return RefreshIndicator(
                  //! Adds a pull-to-refresh behavior to refresh the product list
                  onRefresh: () async {
                    context.read<FavoriteCubit>().getFavoriteProduct();
                    return Future.delayed(Duration(seconds: 4));
                  },
                  displacement: 50,
                  color: Colors.blueAccent,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    //! Builds a grid of favorite products
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.w, //! Defines grid item width
                        mainAxisSpacing: 10.h, //! Spacing between rows
                        crossAxisSpacing: 10.w, //! Spacing between columns
                        mainAxisExtent: 380, //! Defines grid item height
                      ),
                      itemCount: favProducts.length,
                      //! Builds each product card inside the grid
                      itemBuilder: (context, index) {
                        return cardProduct(favProducts, index);
                      },
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('No Favorite'),
                            // WavyAnimatedText('Look at the waves'),
                          ],
                          isRepeatingAnimation: true,
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                      Icon(
                        Icons.heart_broken_sharp,
                        size: 230,
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              }
            } else {
              //! Displays a message if there is no internet connection
              return Center(child: Text('No InterNet'));
            }
          },
        )
            //! Animations to make the UI look smoother when loading the content
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
            .scale(duration: 600.ms, curve: Curves.easeOutBack)
            .move(
              begin: Offset(0, -20),
              delay: 100.ms,
              duration: 600.ms,
              curve: Curves.easeInOut,
            )
            .then(),
      ),
    );
  }

  //! This method builds each individual product card with its layout and details
  InkWell cardProduct(List<Product> products, int index) {
    return InkWell(
      //! On tapping the product card, the user will be taken to the product details page (currently commented out)
      onTap: () {
        // Navigator.push(

        // );
      },
      //! Main layout of the product card
      child: SizedBox(
        height: 380,
        child: Stack(
          children: [
            //! Builds the content inside the product card (image, details, price)
            SizedBox(
              width: 182.w,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(),
                child: Column(
                  children: [
                    //! Displays the product image
                    Container(
                      height: 184.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(products[index].imageCover),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        //! Adds animations to the image for smooth appearance
                        .animate()
                        .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
                        .scale(duration: 600.ms, curve: Curves.easeOutBack)
                        .move(
                          begin: Offset(0, -20),
                          delay: 100.ms,
                          duration: 600.ms,
                          curve: Curves.easeInOut,
                        )
                        .then(),
                    //! Displays product information (rating, title, category, price)
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! Row for the product rating (stars and number of ratings)
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 8),
                            child: Row(
                              children: [
                                _getStarRating(products[index]
                                    .ratingsQuantity
                                    .toDouble()), //! Displays star ratings
                                Text(
                                    "(${products[index].ratingsQuantity})"), //! Displays number of ratings
                              ],
                            ),
                          ),
                          //! Product title
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              products[index].title,
                              style: TTextTheme.lightTextThem.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          //! Product category
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              products[index].category.name,
                              style: TTextTheme.lightTextThem.titleLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          //! Product price with discount if available
                          products[index].trending
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${products[index].price}\$",
                                        style: TextStyle(
                                          decoration: TextDecoration
                                              .lineThrough, //! Original price strikethrough
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      )
                                          //! Animations for price details
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
                                          .shake(
                                            delay: 500.ms,
                                            hz: 4,
                                            curve: Curves.elasticOut,
                                          ),
                                      SizedBox(width: 5.w),
                                      //! Discounted price
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
            //! Displays discount badge if the product is trending
            Positioned(
              top: 10.h,
              left: 10.w,
              child: products[index].trending
                  ? Container(
                      alignment: Alignment.center,
                      height: 24.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Text(
                        "-${calculateDiscount(products[index].price.toInt(), products[index].priceAfterDiscount.toInt())}%", //! Calculates the discount percentage
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
            //! Icon to remove the product from the favorites list
            Positioned(
              top: 1.h,
              right: 2.w,
              child: IconButton(
                onPressed: () {
                  context
                      .read<FavoriteCubit>()
                      .removeFavorite(id: products[index].id);
                  products[index].isFavorite = false;

                  setState(() {
                    products.removeAt(
                        index); //! Removes product from the list and refreshes the UI
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //! Method to display the product star rating using the Flutter Rating Bar
  RatingBar _getStarRating(double rating) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 10.w,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

  //! Helper function to calculate discount percentage
  int calculateDiscount(int originalPrice, int discountedPrice) {
    double discount = 100 * (originalPrice - discountedPrice) / originalPrice;
    return discount.round();
  }
}
