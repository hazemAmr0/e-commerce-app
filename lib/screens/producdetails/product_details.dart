import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/consts/seccess_alertdialog.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, this.productId}) : super(key: key);
  final String? productId;

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final getCurrProduct = productProvider.productsById(productId!);
    final getProductIncard = Provider.of<CartProvider>(context);
    return Scaffold(
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              // Wrap the Padding widget with a SingleChildScrollView
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            getCurrProduct.productImage!,
                            // height: 200.h,
                            // width: 200.w,
                            scale: 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      getCurrProduct.productTitle!,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getCurrProduct.productPrice!,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(IconlyLight.heart),
                          color: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      getCurrProduct.productCategory!,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      getCurrProduct.productDescription!,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                        height:
                            16.0), // Adjusted to avoid using Spacer in scrollable view
                    Center(
                      child: SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: TextButton.icon(
                              onPressed: () {
                                if (getProductIncard.IsProductInCart(
                                    productId: getCurrProduct.productId!)) {
                                  getProductIncard.removeFromCart(
                                      productId: getCurrProduct.productId!);
                                  showSuccessDialog(
                                      context, 'Product removed from cart');
                                } else {
                                  getProductIncard.addToCart(
                                      productId: getCurrProduct.productId!);
                                  showSuccessDialog(
                                      context, 'Product added to cart');
                                }
                              },
                              icon: getProductIncard.IsProductInCart(
                                      productId: getCurrProduct.productId!)
                                  ? Icon(Icons.check_circle, color: Colors.white)
                                  : Icon(Icons.add_shopping_cart,
                                      color: Colors.white),
                              label: Text(
                                getProductIncard.IsProductInCart(
                                        productId: getCurrProduct.productId!)
                                    ? 'Added to cart'
                                    : 'Add to cart',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    getProductIncard.IsProductInCart(
                                            productId:
                                                getCurrProduct.productId!)
                                        ? MaterialStateProperty.all<Color>(
                                            Colors.green)
                                        : MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ))),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
