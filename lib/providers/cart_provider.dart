import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCart => _cartItems;

  // Firebase
  final userDB = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  // Stream to listen to cart changes
  Stream<List<CartModel>> cartStream() {
    final User? user = auth.currentUser;
    if (user == null) {
      return const Stream
          .empty(); // Empty stream when the user is not logged in
    }

    final uid = user.uid;
    return userDB.doc(uid).snapshots().map((document) {
      final data = document.data();
      if (data == null || !data.containsKey('userCart')) {
        return []; // Return an empty list if there's no cart data
      }

      final List<dynamic> cartItems = data['userCart'] as List<dynamic>;
      final List<CartModel> loadedCartItems = [];

      for (final item in cartItems) {
        if (item is Map<String, dynamic>) {
          loadedCartItems.add(
            CartModel(
              cartId: item['cartId'],
              productId: item['productId'],
              quantity:
                  int.tryParse(item['quantity']) ?? 0, // Safely parse quantity
            ),
          );
        }
      }

      // Update local cart items
      _cartItems = {
        for (var cartItem in loadedCartItems) cartItem.productId: cartItem
      };

      notifyListeners(); // Notify listeners when cart changes
      return loadedCartItems;
    });
  }
  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }
  // Other methods remain unchanged
  Future<void> addToCartFirebase({
    required String productId,
    required BuildContext context,
    required String quantity,
  }) async {
    final User? user = auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please login first'),
        ),
      );
      return;
    }
    final uid = user.uid;
    final cartId = const Uuid().v4();
    try {
      await userDB.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {'cartId': cartId, 'productId': productId, 'quantity': quantity}
        ])
      });
      print('Cart added to Firebase.');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> removeFromCartFirebase({
    required String productId,
    required String cartId,
    required String quantity,
  }) async {
    final User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      await userDB.doc(uid).update({
        'userCart': FieldValue.arrayRemove([
          {
            'productId': productId,
            'quantity': quantity,
            'cartId': cartId,
          }
        ])
      });
      print('Cart removed from Firebase.');
    } catch (e) {
      print('Error removing cart: $e');
    }
  }

  Future<void> clearCartFirebase() async {
    final User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      await userDB.doc(uid).update({'userCart': []});
      print('Cart cleared from Firebase.');
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

  void updateQuantity({required String productId, required int quantity}) {
    _cartItems.update(
        productId,
        (value) => CartModel(
            cartId: value.cartId, quantity: quantity, productId: productId));
    notifyListeners();
  }

  double totalAmount({required ProductProvider productProvider}) {
    double total = 0.0;
    _cartItems.forEach((key, cartItem) {
      final product = productProvider.productsById(cartItem.productId);
      if (product != null) {
        total += double.parse(product.productPrice!) * cartItem.quantity;
      }
    });

    return total;
  }

  int totalItems() {
    int total = 0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.quantity;
    });

    return total;
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
