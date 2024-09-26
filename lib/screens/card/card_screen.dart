import 'package:e_commerce_app/consts/seccess_alertdialog.dart';
import 'package:e_commerce_app/consts/widgets/empty_screen.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/card/widgets/cart_item_widget.dart';
import 'package:e_commerce_app/screens/card/widgets/checkout%20widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/models/cart_model.dart';

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    return StreamBuilder<List<CartModel>>(
      stream: cartProvider.cartStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const EmptyScreen(
            img: 'assets/images/emptybox.png',
            title1: 'Your Cart is Empty',
            title2: 'Looks like you didn\'t add anything yet',
            title3: 'Shop Now',
          );
        }

        final cartItems = snapshot.data!;

        return   Scaffold(
            appBar: AppBar(
              title: const Text('My Cart'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showRemoveAllItemsDialog(context, cartProvider);
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.getCart.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: cartProvider.getCart.values.toList()[index],
                          child: const CartItemWidget(),
                        );
                      },
                    ),
                  ),
                  TotalPriceWidget(
                    totalPrice: cartProvider.totalAmount(
                      productProvider: productProvider,
                    ),
                  ),
                ],
              ),
            ),
          );
      

      },

    );
}
      
}
  

