import 'package:e_commerce_app/consts/routting/App_router.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/consts/theme_data.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:e_commerce_app/providers/order_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      initialRoute = Routes.login;
     
    } else {
      initialRoute = Routes.rootScreen;
      
    }
  });

  runApp(MyApp(appRouter: AppRouter()));

  // SendNotification().sendPushMessage();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('7f6cc79a-99b1-4398-b4d5-fe76186562f8');
  OneSignal.Notifications.requestPermission(true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ProductProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => OrderProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => FavoriteProvider(),
            ),
          ],
          child:
              Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'BuyiT',
              debugShowCheckedModeBanner: false,
              theme: Style.themeData(
                isDark: themeProvider.Isdark_theme,
                context: context,
              ),
              onGenerateRoute: appRouter.generateRoute,
              initialRoute: initialRoute,
            );
          }),
        );
      },
    );
  }
}
