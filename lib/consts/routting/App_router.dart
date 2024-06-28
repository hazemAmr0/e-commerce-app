
import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/root_scree.dart';
import 'package:e_commerce_app/screens/auth/forget_password.dart';
import 'package:e_commerce_app/screens/auth/login_screen.dart';
import 'package:e_commerce_app/screens/auth/signin_Screen.dart';
import 'package:e_commerce_app/screens/producdetails/product_details.dart';
import 'package:e_commerce_app/screens/profile/sections/favoriets.dart';
import 'package:e_commerce_app/screens/profile/sections/viewed.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.productDetails:
        return MaterialPageRoute(builder: (_) => const ProductDetails());
        case Routes.rootScreen:
        return MaterialPageRoute(builder: (_) => const RootScreen ());
         case Routes.favorites:
        return MaterialPageRoute(builder: (_) => const Favorites());
          case Routes.viewed:
        return MaterialPageRoute(builder: (_) => const Viewed());
         case Routes.login:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
              case Routes.signUp:
        return MaterialPageRoute(builder: (_) => SignUp());
        case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPassword());


      // Add other cases as needed
      default:
        // This is a fallback route in case an undefined route is navigated to.
        return MaterialPageRoute(
            builder: (_) =>
                const RootScreen()); // Assuming NotFoundPage is a defined widget for unknown routes
    }
  }
}
