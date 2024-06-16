import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app/screens/profile/widgets/favorite_card.dart';
import 'package:e_commerce_app/screens/search/widgets/item_card.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: ListView.builder(
        itemCount: 4,
          itemBuilder: (context, index) => FavoriteCard(),
          
        ));
  }
}
