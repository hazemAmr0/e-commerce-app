import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app/screens/search/widgets/item_card.dart';
import 'package:flutter/material.dart';

class Viewed extends StatelessWidget {
  const Viewed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Viewed'),
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
        body: DynamicHeightGridView(
            builder: (context, index) => ItemCard(
                  img: 'assets/images/shoes.png',
                  title: 'Nike shoes',
                  price: '\$120',
                ),
            itemCount: 4,
            crossAxisCount: 2));
  }
}
