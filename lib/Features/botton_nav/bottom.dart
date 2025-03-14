// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahm/Features/cart/cart_page.dart';
import 'package:sahm/controller/shop_home/sahm_cubit.dart';
import 'package:sahm/Features/Favorite/favorite_screen.dart';
import 'package:sahm/Features/Shop/brands.dart';
import 'package:sahm/Features/Shop/shoping_screen.dart';
import 'package:sahm/Features/home/home_page.dart';

import '../../core/themes/const.dart';

class BottomNabigation extends StatefulWidget {
  final int initialIndex;

  const BottomNabigation({
    Key? key,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _BottomNabigationState createState() => _BottomNabigationState();
}

class _BottomNabigationState extends State<BottomNabigation> {
  late int _tabIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.initialIndex;
    pageController = PageController(initialPage: _tabIndex);
    context.read<SahmCubit>().getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          setState(() {
            _tabIndex = v;
          });
        },
        children: [
          //! home
          HomePage(),
          //! shop
          // ShopPage(),
          ShopingScreen(),
          //! cart
          CartPage(),
          //! favorite
          FavoriteScreen(),
          //! profile
          Center(child: Text("5")),
        ],
      ),
      bottomNavigationBar: CircleNavBar(
        circleColor: Colors.white,
        activeIcons: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.home,
              color: kprimaryColor,
            ),
            Text(
              "Home",
              style: TextStyle(
                color: kprimaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.shopping_cart,
              color: kprimaryColor,
            ),
            Text(
              "Shop",
              style: TextStyle(
                color: kprimaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.shopping_bag,
              color: kprimaryColor,
            ),
            Text(
              "Cart",
              style: TextStyle(
                color: kprimaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.favorite,
              color: kprimaryColor,
            ),
            Text(
              "Favorite",
              style: TextStyle(
                color: kprimaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: kprimaryColor,
              ),
              Text(
                "Profile",
                style: TextStyle(
                  color: kprimaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
        inactiveIcons: const [
          Column(children: [
            Icon(
              Icons.home_outlined,
              color: Color(0xff9B9B9B),
            ),
            Text(
              "Home",
              style: TextStyle(
                color: Color(0xff9B9B9B),
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ]),
          Column(children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xff9B9B9B),
            ),
            Text(
              "Shop",
              style: TextStyle(
                color: Color(0xff9B9B9B),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
          Column(children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xff9B9B9B),
            ),
            Text(
              "Cart",
              style: TextStyle(
                color: Color(0xff9B9B9B),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
          Column(children: [
            Icon(
              Icons.favorite_outline_rounded,
              color: Color(0xff9B9B9B),
            ),
            Text(
              "Favorite",
              style: TextStyle(
                color: Color(0xff9B9B9B),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
          Column(children: [
            Icon(
              Icons.person_outline_outlined,
              color: Color(0xff9B9B9B),
            ),
            Text(
              "Profile",
              style: TextStyle(
                color: Color(0xff9B9B9B),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
        ],
        color: Colors.white,
        circleShadowColor: kprimaryColor,
        height: 60,
        circleWidth: 60,
        activeIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
            pageController.jumpToPage(_tabIndex);
          });
        },
        shadowColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}
