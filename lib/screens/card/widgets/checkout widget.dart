import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TotalPriceWidget extends StatelessWidget {
  final double totalPrice;

  const TotalPriceWidget({Key? key, required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartprovider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'No.of product : ',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber), // Default text style
                      children: <TextSpan>[
                        TextSpan(
                          text: '${cartprovider.getcart.length}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'No.of items : ',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ), // Default text style
                      children: <TextSpan>[
                        TextSpan(
                          text: '${cartprovider.totalItems()}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Total price : ',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber), // Default text style
                      children: <TextSpan>[
                        TextSpan(
                          text: '${totalPrice.toStringAsFixed(2)} \$',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: ()async {
                     await placeOrder(
                        context: context,
                        cartprovider: cartprovider,
                        userProvider: userProvider,
                        productProvider: productProvider,
                  
                      );
                    },
                    child: Text(
                      'Check out',
                      style: TextStyle(
                        color: Colors.white,
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
Future<void> placeOrder({
  BuildContext? context,
  required CartProvider cartprovider,
  required UserProvider userProvider,
  required ProductProvider productProvider,
}) async {
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if (user == null) {
    return;
  }
  final uid = user.uid;

  try {
    for (var cartItem in cartprovider.getcart.values) {
      final orderId = const Uuid().v4();
      final currentProduct = productProvider.productsById(cartItem.productId);
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(uid) // Store orders under the user's uid
          .collection(
              'userOrders') // Create a subcollection for each user's orders
          .doc(orderId) // The document ID for each order
          .set({
        'orderId': orderId,
        'userId': uid,
        'productId': cartItem.productId,
        'product title': currentProduct!.productTitle,
        'price': currentProduct.productPrice,
        'imageUrl': currentProduct.productImage,
        'quantity': cartItem.quantity,
        'orderStatus': 'pending',
        'address': 'الطالبيه فيصل -الجيزه',
        'username': userProvider.userModel!.name,
        'orderDate': Timestamp.now(),
        'totalPrice':
            cartprovider.totalAmount(productProvider: productProvider),
      }).then((value) => ScaffoldMessenger.of(context!).showSnackBar(
                const SnackBar(content: Text('Order placed successfully')),
              ));
    }

    await cartprovider.clearCartFirebase();
    cartprovider.clearLocalCart();
  } catch (e) {
    print('Error placing order: $e');
  }
}


