import 'package:e_commerce_app/consts/theme_data.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/root_scree.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
   
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          child: MaterialApp(      
            debugShowCheckedModeBanner: false, 

            title: 'E-commerce App',
            theme: Style.themeData(
                isDark: themeProvider.Isdark_theme, context: context),
            home: RootScreen(),
          ),
        );
      }),
    );
  }
}
