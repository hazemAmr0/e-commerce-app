import 'package:e_commerce_app/consts/routting/App_router.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/consts/theme_data.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/root_scree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp( MyApp(appRouter: AppRouter(),));
   
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return ScreenUtilInit(
           designSize: const Size(375, 812),
          child: MaterialApp(      
            debugShowCheckedModeBanner: false, 

            title: 'E-commerce App',
            theme: Style.themeData(
                isDark: themeProvider.Isdark_theme, context: context),
            home: RootScreen(),
            onGenerateRoute: appRouter.generateRoute,
            initialRoute: Routes.rootScreen,
          ),
        );
      }),
    );
  }
}
