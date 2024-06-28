import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style{
static ThemeData themeData({required bool isDark, required BuildContext context}){

  return ThemeData(
   scaffoldBackgroundColor: isDark ? AppColor.darkScaffoldColor: AppColor.lightScaffoldColor,
    brightness: isDark ? Brightness.dark : Brightness.light,
    cardColor: isDark ? AppColor.black : AppColor.lightCardColor,
    textTheme:  GoogleFonts.ibmPlexSansTextTheme(
      Theme.of(context).textTheme.apply(bodyColor: isDark ? AppColor.white : Colors.black)
    ),
  
    );
  
} 


}