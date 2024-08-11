import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            minVerticalPadding: 35,
            leading:Hero(
              tag: cartprovider.productId,
              child: CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl: getCurrProductById!.productImage!,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            title: Text(
              getCurrProductById.productTitle!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${getCurrProductById.productPrice!} EGP',
              style: const TextStyle(
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
                      icon: const Icon(Icons.remove),
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
                      icon: const Icon(Icons.add),
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
          child: const Text(
            'Remove',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            cart.removeFromCartFirebase(productId: cartprovider.productId, cartId: cartprovider.cartId, quantity: cartprovider.quantity.toString());
          },
        ),
      ),
    ]);
  }
}
