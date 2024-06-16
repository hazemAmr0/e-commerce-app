import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
    color: themeProvider.Isdark_theme? AppColor.favoritecolordark:Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        minVerticalPadding: 35,
        leading: Image.asset(
          'assets/images/categories/shoes.png',
                ),
        title: Text(
          'shoes',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '\$120',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 16,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
           
            
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
              //  onQuantityChanged(cartItem.quantity + 1);
              },
            ),
          ],
        ),
      ),
    );
    ;
  }
}