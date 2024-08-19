import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/card/card_screen.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/screens/search/search_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<RootScreen> {
  bool isLoadingProds = true;
  @override
  initState() {
    super.initState();
    _fetchData();
  }
  Future<void> _fetchData() async {
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      await Future.wait([
        // productsProvider.fetchProducts(), // Uncomment if needed
        userProvider.fetchUserInfo(),
        cartProvider.fetchCart(),
      ]);

      // Fetch favorites
      wishlistProvider.fetchFavorites();
    } catch (error) {
      print(error.toString());
    } finally {
      setState(() {
        isLoadingProds = false;
      });
      // Any final operations if needed
    }
  }
  int myCurrentIndex = 0;
  List pages = [
    HomeScreen(),
    SearchScreen(),
    CardScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 25,
              offset: const Offset(8, 20))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
              // backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[800],
              currentIndex: myCurrentIndex,
              enableFeedback: false,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: themeProvider.Isdark_theme
                  ? Colors.grey[500]
                  : Colors.black87,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconlyBold.home), label: "home"),
                BottomNavigationBarItem(
                    icon: Icon(IconlyBold.category), label: "search"),
                BottomNavigationBarItem(
                    icon: Icon(IconlyBold.bag), label: "card"),
                BottomNavigationBarItem(
                    icon: Icon(IconlyBold.profile), label: "Profile"),
              ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
