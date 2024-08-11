import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/consts/app_colors.dart';

import 'package:e_commerce_app/models/favorite_model.dart';

import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/screens/producdetails/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key,});

  

  @override
  Widget build(BuildContext context) {
    
      final productProvider = Provider.of<ProductProvider>(context);
    final cartvaf = Provider.of<FavoriteModel>(context);
    final cart = Provider.of<FavoriteProvider>(context);
    final getCurrProductById =
        productProvider.productsById(cartvaf.productId);
     
  
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              productId: cartvaf.productId,
            ),
          ),
        );
      },
      child: Card(
      color: themeProvider.Isdark_theme? AppColor.favoritecolordark:Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          minVerticalPadding: 35,
          leading: Hero(
            tag: cartvaf.productId,
            child: CachedNetworkImage(
              height: 50,width: 50,
              imageUrl: getCurrProductById!.productImage!,
              placeholder: (context, url) => Center(
                child: Icon(Icons.photo_rounded),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            
            ),
          ),
          title: Text(
            getCurrProductById.productTitle!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${getCurrProductById.productPrice!} EGP',
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
                onPressed: () {
                 if(cart.isProductFavorite(productId: cartvaf.productId)){
                   cart.removeFromFavoriteFirebase(
                     productId: cartvaf.productId,
                     favoriteId: cartvaf.favoriteId,
                   );

                 } else {
                   cart.addToFavoriteFirebase(
                     productId: cartvaf.productId,
                     context: context,
                   );
                 }

                },
                
                icon: Icon(
                  cart.isProductFavorite(
                    productId: cartvaf.productId,
                  )
                      ? IconlyBold.heart
                      : IconlyLight.heart,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}