
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/consts/seccess_alertdialog.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/screens/producdetails/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCard extends StatelessWidget {
  ItemCard({required this.productId});

  final String productId;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    final themeProvider = Provider.of<ThemeProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productProvider.productsById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    // ignore: unused_local_variable
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(productId: productId),
          ),
        );
      },
      child: getCurrProduct == null
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200.w,
                decoration: BoxDecoration(
                  color: themeProvider.Isdark_theme
                      ? AppColor.cardcolordark
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 1,
                      //offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: themeProvider.Isdark_theme
                                ? AppColor.darkPrimary
                                : Colors.blue[50],
                          ),
                          child: Center(
                            child: Hero(
                              tag: productId,
                              child: CachedNetworkImage(
                                imageUrl: getCurrProduct.productImage!,
                                placeholder: (context, url) => Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  height: 150,
                                  width: double.infinity,
                                ), // Show loading indicator
                                errorWidget: (context, url, error) => const Icon(Icons
                                    .error), // Show error icon in case of any error
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                if (favoriteProvider.isProductFavorite(
                                  productId: getCurrProduct.productId!,
                                )) {
                                  favoriteProvider.removeFromFavoriteFirebase(
                                    productId: getCurrProduct.productId!,
                                    favoriteId: favoriteProvider
                                        .getFavorites[
                                            getCurrProduct.productId!]!
                                        .favoriteId,
                                  );
                                } else {
                                  favoriteProvider.addToFavoriteFirebase(
                                    context: context,
                                    productId: getCurrProduct.productId!,
                                  );
                                }
                              },
                              icon: Icon(
                                favoriteProvider.isProductFavorite(
                                  productId: getCurrProduct.productId!,
                                )
                                    ? IconlyBold.heart
                                    : IconlyLight.heart,
                                color: Colors.red,
                              ),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                             getCurrProduct.productTitle?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                           ' ${getCurrProduct.productPrice} EGP' ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: Colors.amber, size: 11.sp),
                              Icon(Icons.star,
                                  color: Colors.amber, size: 11.sp),
                              Icon(Icons.star,
                                  color: Colors.amber, size: 11.sp),
                              Icon(Icons.star,
                                  color: Colors.amber, size: 11.sp),
                              Icon(Icons.star_border,
                                  color: Colors.amber, size: 11.sp),
                              const SizedBox(width: 5),
                              Text(
                                '(3.0)',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (cartProvider.isProductInCart(
                                      productId: getCurrProduct.productId!)) {
                                    cartProvider.removeFromCartFirebase(
                                      productId: getCurrProduct.productId!,
                                      cartId: cartProvider
                                          .getcart[getCurrProduct.productId!]!
                                          .cartId,
                                      quantity: cartProvider
                                          .getcart[getCurrProduct.productId!]!
                                          .quantity
                                          .toString(),
                                    );
                                    showSuccessDialog(
                                        context, 'Product removed from cart');
                                  } else {
                                    try {
                                      await cartProvider.addToCartFirebase(
                                        context: context,
                                        productId: getCurrProduct.productId!,
                                        quantity: '1',
                                      );
                                      showSuccessDialog(
                                          context, 'Product added to cart');
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  }
                                  // cartProvider
                                  //     .addToCart(
                                  //     productId: getCurrProduct
                                  //         .productId!);
                                },
                                icon: cartProvider.isProductInCart(
                                        productId: getCurrProduct.productId!)
                                    ? const Icon(Icons.check_circle)
                                    : const Icon(Icons.add_shopping_cart),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void showSuccessAlertDialog(
      {required BuildContext context,
      required String title,
      required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
