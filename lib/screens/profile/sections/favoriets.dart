import 'package:e_commerce_app/consts/widgets/empty_screen.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:e_commerce_app/screens/profile/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider =
        Provider.of<FavoriteProvider>(context, listen: false);

    return StreamBuilder<void>(
      stream: wishlistProvider.fetchFavoritesStream(),
      builder: (context, snapshot) {
        if (wishlistProvider.getFavorites.isEmpty) {
          return Scaffold(
            body: EmptyScreen(
              img: 'assets/images/emptybox.png',
              title1: 'No Favorites',
              title2: 'Add favorites products',
              title3: 'Shop Now',
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  wishlistProvider.clearFavoritesFirebase();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: ListView.builder(
            itemCount: wishlistProvider.getFavorites.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: wishlistProvider.getFavorites.values
                    .toList()
                    .reversed
                    .toList()[index],
                child: const FavoriteCard(),
              );
            },
          ),
        );
      },
    );
  }
}
