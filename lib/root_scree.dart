import 'dart:ffi';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/screens/card/card_screen.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/screens/search/search_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController pageController;
  int currentPage = 0;
  List<Widget> Screens = [
    HomeScreen(),
    SearchScreen(),
    CardScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Cartprovider = Provider.of<CartProvider>(context);
final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: Screens,
          ),
          Positioned(
            bottom: 10.0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: ClipRRect(
                //borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: CustomNavigationBar(
               //  strokeColor :Colors.white,
               bubbleCurve : Curves.easeInOut,
                  scaleCurve : Curves.easeInOut,
                  scaleFactor : 0.5,
                  iconSize: 30.0,
                  selectedColor: Colors.white,
                  strokeColor: Colors.white,
                  unSelectedColor: Colors.white,
                 blurEffect : false,
                  backgroundColor: themeProvider.Isdark_theme ? Colors.white38! : Colors.black45,
                  borderRadius: Radius.circular(30.0),
                  elevation: 8.0,
                  currentIndex: currentPage,
                  onTap: (index) {
                    setState(() {
                      currentPage = index;
                    });
                    pageController.jumpToPage(index);
                  },
                  items: [
                    CustomNavigationBarItem(
                      icon: Icon(IconlyLight.home, color: Colors.white),
                     // title: Text('Home', style: TextStyle(color: Colors.white)),
                      selectedIcon: Icon(IconlyBold.home, color: Colors.white),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(IconlyLight.search, color: Colors.white),
                      //title:
                        //  Text('Search', style: TextStyle(color: Colors.white)),
                      selectedIcon: Icon(IconlyBold.search, color: Colors.white),
                    ),
                    CustomNavigationBarItem(
                      icon: Cartprovider.getcart.isEmpty
                          ? Icon(IconlyLight.buy, color: Colors.white)
                          : Badge(
                              backgroundColor: Colors.red,
                              label: Text(
                                Cartprovider.getcart.length.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              child: Icon(IconlyLight.buy, color: Colors.white),
                            ),
                     // title: Text('Cart', style: TextStyle(color: Colors.white)),
                      selectedIcon: Icon(IconlyBold.buy, color: Colors.white),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(IconlyLight.profile, color: Colors.white),
                      //title:
                        //  Text('Profile', style: TextStyle(color: Colors.white)),
                      selectedIcon: Icon(IconlyBold.profile, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
