// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sahm/controller/Favorite/favorite_cubit.dart';
import 'package:sahm/controller/shop_home/sahm_cubit.dart';
import 'package:sahm/core/models/product_model.dart';
import 'package:sahm/core/themes/text_theme.dart';
import 'package:sahm/Features/details_screen/view/details_screen.dart';
import 'package:sahm/Features/home/home_widget/botton_home.dart';
import 'package:sahm/Features/home/home_widget/discount_banner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahm/Features/home/home_widget/title_new_sale_home.dart';
import 'package:flutter_animate/flutter_animate.dart';

//! Main Home Page Widget
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

//! State class for HomePage
class _HomePageState extends State<HomePage> {
  //! Toggle the favorite status of a product

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      //! Refreshes the product list when pulled down
      onRefresh: () {
        context.read<SahmCubit>().getProduct();
        return Future.delayed(Duration(seconds: 3));
      },
      displacement: 50,
      color: Colors.blueAccent,
      backgroundColor: Colors.white,
      strokeWidth: 3.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //! Displays a discount banner
            DiscountBanner(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  //! Home buttons for navigation
                  BottonForHome(),
                  SizedBox(height: 10.h),

                  //! Title for sale section
                  TitleHomeSaleORNew(
                    title: 'Sale',
                    supTitle: 'Super summer sale',
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<SahmCubit, SahmState>(
                    //! Manages the state of product loading
                    builder: (context, state) {
                      if (state is SahmLoading) {
                        //! Shows loading indicator while products are loading
                        return Center(
                          child: LoadingAnimationWidget.inkDrop(
                            size: 50,
                            color: Colors.green,
                          ),
                        );
                      } else if (state is SahmError) {
                        //! Displays error message if loading fails
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
                      } else if (state is SuccessGetProduct) {
                        final products = state.products;

                        return Column(
                          children: [
                            //! Trending products section
                            SizedBox(
                              height: 350.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  if (product.trending) {
                                    return itemCart(
                                        product); //! Displays product card for trending products
                                  } else {
                                    return Center(
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            WavyAnimatedText(
                                              '         No Sale       ',
                                              speed:
                                                  Duration(milliseconds: 250),
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
                                    ); // Hide product if not trending
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                            //! Title for new products section
                            TitleHomeSaleORNew(
                              title: 'New',
                              supTitle: 'You’ve never seen it before!',
                            ),
                            SizedBox(height: 20.h),
                            //! New products section
                            SizedBox(
                              height: 320.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  if (product.specials) {
                                    return itemCart(
                                        product); //! Displays product card for special products
                                  } else {
                                    return Center(
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            WavyAnimatedText(
                                              '         No New       ',
                                              speed:
                                                  Duration(milliseconds: 250),
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
                                    ); // Hide product if not special
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      } else {
                        return Center(
                            child: Text(
                                'No Internet')); //! Displays a message if there is no internet
                      }
                    },
                  ),
                ],
              ),
            ),
          ]
              .animate()
              .fadeIn() // uses `Animate.defaultDuration`
              .scale() // inherits duration from fadeIn
              .move(
                  delay: 20.ms,
                  duration: 600.ms), // runs after the above w/new duration
        ),
      ),
    );
  }

  //! Creates a product card
  Widget itemCart(Product product) {
    return InkWell(
      onTap: () {
        //! Navigates to the product details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DetailsScreen(
              product: product,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          SizedBox(
            width: 182.w,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(),
              child: Column(
                children: [
                  //! Displays product image
                  Container(
                    height: 184.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.imageCover),
                        fit: BoxFit.cover,
                      ),
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
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              //! Displays product rating
                              Rating(
                                  rating: product.ratingsQuantity.toDouble()),
                              Text("(${product.ratingsQuantity})")
                                  .animate()
                                  .fadeIn()
                                  .scale()
                                  .move(delay: 20.ms, duration: 600.ms)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            product.title,
                            style: TTextTheme.lightTextThem.labelMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            product.category.name,
                            style: TTextTheme.lightTextThem.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //! Displays product price with discount if applicable
                        product.trending
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "${product.price}\$",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    )
                                        .animate()
                                        .fadeIn(duration: 600.ms)
                                        .then(delay: 200.ms),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "${product.priceAfterDiscount}\$",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                        .animate()
                                        .fadeIn(duration: 600.ms)
                                        .then(delay: 200.ms),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Text(
                                  "${product.priceAfterDiscount}\$",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                                .animate()
                                .fadeIn(duration: 600.ms)
                                .then(delay: 200.ms),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 110.h,
            right: 5.w,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10.h,
            left: 10.w,
            child: product.trending
                ? Container(
                    alignment: Alignment.center,
                    height: 24.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: Text(
                      "-${calculateDiscount(product.price.toInt(), product.priceAfterDiscount.toInt())}%",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 24.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: Text(
                      "New",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
          Positioned(
            bottom: 120.h,
            right: 5.w,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: favoriteBotton(product)
                  .animate()
                  .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
                  .then(delay: 100.ms),
            ),
          ),
        ],
      ),
    );
  }

  IconButton favoriteBotton(Product product) {
    return IconButton(
      onPressed: () {
        context.read<FavoriteCubit>().addFavorite(id: product.id);
        setState(() {
          product.isFavorite
              ? context.read<FavoriteCubit>().removeFavorite(id: product.id)
              : context.read<FavoriteCubit>().addFavorite(id: product.id);
          product.isFavorite = !product.isFavorite;
        });
      },
      icon: product.isFavorite
          ? Icon(Icons.favorite, color: Colors.red)
          : Icon(Icons.favorite_border_outlined),
    );
  }

//! the func for sale
  int calculateDiscount(int price, int priceAfterDiscount) {
    return ((price - priceAfterDiscount) / price * 100).round();
  }
}

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: true,
      itemSize: 15,
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
