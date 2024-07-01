import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productProvider.productsById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
     final  favoriteprovider=Provider.of<FavoriteProvider>(context);
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
          ? CircularProgressIndicator()
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
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 1),
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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: themeProvider.Isdark_theme
                                ? AppColor.darkPrimary
                                : Colors.blue[50],
                          ),
                          child: Center(
                              child: Image.network(
                            getCurrProduct.productImage ?? '',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child:IconButton(
                            onPressed: () {
                              favoriteprovider.addOrRemovefromFavorite(
                                productId: getCurrProduct.productId!
                              );
                            },
                            icon: Icon(
                              favoriteprovider.isFavorite(
                               getCurrProduct.productId!,
                              )
                                  ? IconlyBold.heart
                                  : IconlyLight.heart,
                              color: Colors.red,
                            ),
                          )
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getCurrProduct.productTitle ?? '',
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
                            getCurrProduct.productPrice ?? '',
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
                              SizedBox(width: 5),
                              Text(
                                '(3.0)',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if(
                                    cartProvider.IsProductInCart(
                                        productId: getCurrProduct.productId!)
                                  ){
                                    cartProvider
                                        .removeFromCart(
                                        productId: getCurrProduct
                                            .productId!);
                                    showSuccessDialog(context, 'Product removed from cart');
                                  }else{
                                    cartProvider
                                        .addToCart(
                                        productId: getCurrProduct
                                            .productId!);
                                    showSuccessDialog(context, 'Product added to cart');
                                  
                                  }
                                },
                                icon: cartProvider.IsProductInCart(
                                        productId: getCurrProduct.productId!)
                                    ? Icon(Icons.check_circle)
                                    : Icon(Icons.add_shopping_cart),
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
  
  void showSuccessAlertDialog({required BuildContext context, required String title, required String message}) {
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
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
