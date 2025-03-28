// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahm/Features/details_screen/view/Rating_Review_screen.dart';
import 'package:sahm/controller/AddToCart/add_to_cart_cubit.dart';
import 'package:sahm/controller/Favorite/favorite_cubit.dart';
import 'package:sahm/core/models/product_model.dart';
import 'package:sahm/core/themes/text_theme.dart';
import 'package:sahm/Features/details_screen/widget/appbar.dart';
import 'package:sahm/Features/details_screen/widget/botton_reviews.dart';
import 'package:sahm/Features/details_screen/widget/dropdownbutton.dart';
import 'package:sahm/Features/details_screen/widget/listview_images.dart';
import 'package:sahm/Features/details_screen/widget/rating.dart';
import 'package:share_plus/share_plus.dart';
import "package:firebase_analytics/firebase_analytics.dart";
//! Main screen to display product details
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.product,
  });

  //! The product object passed to the screen
  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // product view LogEvent 
  @override
void initState() {
  super.initState();
 FirebaseAnalytics.instance.logEvent(
    name: "view_product",
    parameters: {
      "product_id": widget.product.id,
      "product_name": widget.product.title,
      "category": widget.product.category.name,
      "price": widget.product.price,
    },
  );
}

  //! Constant padding used across the widgets
  static const EdgeInsets padding = EdgeInsets.all(10.0);
  @override
  Widget build(BuildContext context) {
    //! Bloc provider for AddToCart functionality
    return BlocProvider<AddToCartCubit>(
      create: (context) => AddToCartCubit(),
      child: Scaffold(
        //! App bar with product category name, back button, and share button
        appBar: appBar(
            parText: widget.product.category.name,
            onPressed: () => Navigator.pop(context),
            ShareOnPressed: () {
              setState(() {
                Share.share(
                  widget.product.productLink,
                  subject: 'product',
                );
              });
            }),
        body: Stack(
          children: [
            //! ListView containing product details and images
            ListView(
              children: [
                //! Widget to display product images in a list
                ListViewImages(prod: widget),
                SizedBox(height: 20),
                Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! Dropdown button for product options
                      DropdownButton1(),
                      //! Another dropdown button for additional options
                      DropdownButton2(),
                      Padding(
                        padding: EdgeInsets.all(
                            8.0), //! Padding around the favorite button
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                color: Colors.grey,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          //! IconButton for marking product as favorite
                          child: ClipOval(
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.product.isFavorite
                                        ? context
                                            .read<FavoriteCubit>()
                                            .removeFavorite(
                                                id: widget.product.id)
                                        : context
                                            .read<FavoriteCubit>()
                                            .addFavorite(id: widget.product.id);
                                    widget.product.isFavorite =
                                        !widget.product.isFavorite;
                                      // add to favorite logEvent
                                    FirebaseAnalytics.instance.logEvent(
                                      name: widget.product.isFavorite
                                          ? "add_to_favorites"
                                          : "remove_from_favorites",
                                      parameters: {
                                        "product_id": widget.product.id,
                                        "product_name": widget.product.title,
                                      },
                                    );
                                  });
                                },
                                icon: widget.product.isFavorite
                                    ? Icon(Icons.favorite, color: Colors.red)
                                    : Icon(Icons.favorite_border_outlined),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //! Product name and price section
                Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.product.category.name,
                        style: TTextTheme.lightTextThem.headlineMedium,
                      ),
                      Text(
                        "\$${widget.product.price}",
                        style: TTextTheme.lightTextThem.headlineLarge,
                      ),
                    ],
                  ),
                ),
                //! Product title section
                Padding(
                  padding: padding,
                  child: Text(
                    widget.product.title,
                    style: TTextTheme.lightTextThem.bodySmall,
                  ),
                ),
                //! Product rating section with animations
                Padding(
                  padding: padding,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => ReviewsView(
                                product: widget.product,
                              ),
                          ));
                        },
                        child: Rating(rating: widget.product.ratingsQuantity.toDouble())),
                      Text("(${widget.product.ratingsQuantity})")
                          .animate()
                          .fadeIn()
                          .scale()
                          .move(
                            delay: 20.ms,
                            duration: 600.ms,
                          ),
                    ],
                  ),
                ),
                //! Product description section with animations
                Padding(
                  padding: padding,
                  child: Text(
                    widget.product.description,
                    style: TTextTheme.lightTextThem.bodySmall,
                    textAlign: TextAlign.start,
                  )
                      .animate()
                      .fadeIn()
                      .scale()
                      .move(delay: 20.ms, duration: 600.ms),
                ),
                SizedBox(height: 300),
              ].animate().fadeIn().scale().move(
                    delay: 20.ms,
                    duration: 600.ms,
                  ),
            ).animate().fadeIn().scale().move(
                  delay: 20.ms,
                  duration: 600.ms,
                ),
            //! Positioned widget for the bottom section containing the "Add to Cart" button
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BlocConsumer<AddToCartCubit, AddToCartState>(
                builder: (context, state) {
                  //! Display error message if adding to cart fails
                  if (state is FillAddToCartInitial) {
                    return Center(child: Text(state.errorMasseg));
                  }
                  //! Add to Cart button
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 112.h,
                    color: Colors.white,
                    child: BottonReviews(
                      onPressedToCart: () {
                        context
                            .read<AddToCartCubit>()
                            .addToCart(id: widget.product.id);
                      // add to cart logEvent
                        FirebaseAnalytics.instance.logEvent(
                          name: "add_to_cart",
                          parameters: {
                            "product_id": widget.product.id,
                            "product_name": widget.product.title,
                            "price": widget.product.price,
                          },
                        );
                      },
                    ),
                  );
                },
                //! Listener for cart-related state changes
                listener: (BuildContext context, AddToCartState state) {
                  if (state is SuccessAddToCart) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Success Add To Cart")),
                    );
                  } else if (state is FillAddToCartInitial) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMasseg)),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
