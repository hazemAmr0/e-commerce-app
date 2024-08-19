import 'package:e_commerce_app/consts/routting/App_router.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/consts/theme_data.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:e_commerce_app/providers/order_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/root_scree.dart';
import 'package:e_commerce_app/screens/auth/login_screen.dart';
import 'package:e_commerce_app/screens/profile/sections/orders.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return FutureBuilder<bool>(
            future: _checkLoginStatus(),
            builder: (context, snapshot) {
              Widget home;

              if (snapshot.connectionState == ConnectionState.waiting) {
                home = const Scaffold(
                  body: Center(child: Scaffold()),
                );
              } else if (snapshot.hasError) {
                home = Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else {
                bool isLoggedIn = snapshot.data ?? false;
                home =  isLoggedIn ? const RootScreen() : const LoginScreen();
              }

              return ScreenUtilInit(
                designSize: const Size(375, 812),
                builder: (context, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'E-commerce App',
                  theme: Style.themeData(
                    isDark: themeProvider.Isdark_theme,
                    context: context,
                  ),
                  onGenerateRoute: appRouter.generateRoute,
                  home: home,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isLoggedIn') ?? false;
    } catch (e) {
      throw Exception('Failed to load login status: $e');
    }
  }
}
