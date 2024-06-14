import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/screens/card/card_screen.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/screens/search/search_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  late PageController pageController;
  int currentPage = 0;
  List<Widget> Screens = [
    HomeScreen(),
    SearchScreen(),
    CardScreen(),
    ProfileScreen(),
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(
      initialPage: currentPage,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: Screens,
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: .5,
          selectedIndex: currentPage,
          height: 60,
          onDestinationSelected: (value) {
            setState(() {
              currentPage = value;
            });
            pageController.jumpToPage(value);
          },
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(IconlyBold.home),
                icon: Icon(IconlyLight.home),
                label: "Home"),
            NavigationDestination(
                selectedIcon: Icon(IconlyBold.search),
                icon: Icon(IconlyLight.search),
                label: "Search"),
            NavigationDestination(
                selectedIcon: Icon(IconlyBold.buy),
                icon: Badge(
                  backgroundColor: Colors.red,
                  label: const Text('3'),                 
                  child: Icon(IconlyLight.buy)),
                label: "Card"
                ),
            NavigationDestination(
                selectedIcon: Icon(IconlyBold.profile),
                icon: Icon(IconlyLight.profile),
                label: "Profile"),
          ],
        ));
  }
}
