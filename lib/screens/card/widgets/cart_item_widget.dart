import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/card/card_screen.dart';
import 'package:e_commerce_app/screens/producdetails/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartprovider = Provider.of<CartModel>(context);
    final cart = Provider.of<CartProvider>(context);
    final getCurrProductById =
        productProvider.productsById(cartprovider.productId);

    return Stack(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                productId: cartprovider.productId,
              ),
            ),
          );
        },
        child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            minVerticalPadding: 35,
            leading: Image.network(
              getCurrProductById!.productImage!,
              height: 100,
            ),
            title: Text(
              getCurrProductById.productTitle!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '\$${getCurrProductById.productPrice!}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 16,
              ),
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (cartprovider.quantity > 1) {
                          cart.updateQuantity(
                            productId: cartprovider.productId,
                            quantity: cartprovider.quantity - 1,
                          );
                        }
                      },
                    ),
                    Text(
                      cartprovider.quantity.toString(),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cart.updateQuantity(
                          productId: cartprovider.productId,
                          quantity: cartprovider.quantity + 1,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 10,
        right: 15,
        child: TextButton(
          child: Text(
            'Remove',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            cart.removeFromCart(productId: cartprovider.productId);
          },
        ),
      ),
    ]);
  }
}
