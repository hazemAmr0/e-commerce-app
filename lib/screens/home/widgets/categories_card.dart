import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/screens/search/search_scree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesCard extends StatelessWidget {
  @override
  String? img;
  String? title;
  CategoriesCard({this.img, this.title});
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue,
          backgroundColor: themeProvider.Isdark_theme
              ? AppColor.cardcolordark
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5.0,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchScreen(categoryName: title ,)));
        },
        icon: Image.asset(
          img!, // Replace 'path/to/your/image.png' with the actual path to your image asset
          width: 30, // Adjust the size as needed
          height: 30, // Adjust the size as needed
          // Optional: if you want to apply a color filter to your image
        ),
        label: Text(title!),
      ),
    );
  }
}
