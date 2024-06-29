import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/search/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            builder: (context, index) => ChangeNotifierProvider.value(
              value: Provider.of<ProductProvider>(context).getProducts[index],
              child: ItemCard(
                   productId: 'iphone14-128gb-black',
                  ),
            ),
            itemCount: 4,
            crossAxisCount: 2));
  }
}
