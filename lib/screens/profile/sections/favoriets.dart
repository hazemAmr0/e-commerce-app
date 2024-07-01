import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app/models/favorite_model.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/card/widgets/cart_item_widget.dart';
import 'package:e_commerce_app/screens/card/widgets/empty_screen_widget.dart';
import 'package:e_commerce_app/screens/profile/widgets/favorite_card.dart';
import 'package:e_commerce_app/screens/search/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
     final wishlistProvider = Provider.of<FavoriteProvider>(context);
    return wishlistProvider.favoriteItems.isEmpty ? Scaffold(
      
       body:  EmptyScreen(img: 'assets/images/emptybox.png', title1: 'No Favorites', title2: 'Add favorites products', title3: 'Shop Now')) :  Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  wishlistProvider.clearFavorite();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body:  ListView.builder(
                      itemCount: wishlistProvider.favoriteItems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: wishlistProvider.favoriteItems.values
                        .toList()
                        .reversed
                        .toList()[index],
                          child: FavoriteCard());
                         
                      },
                    ),);
  }
}
