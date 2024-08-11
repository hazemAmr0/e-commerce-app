import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getcart => _cartItems;

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  // Firebase
  final userDB = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

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

      await fetchCart(); // Ensure the cart is updated after adding
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> fetchCart() async {
    User? user = auth.currentUser;
    if (user == null) {
      _cartItems.clear();
      notifyListeners();
      return;
    }
    try {
      final userDoc = await userDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userCart")) {
        _cartItems.clear();
        notifyListeners();
        return;
      }

      final List<dynamic> cartItems = data['userCart'] as List<dynamic>;
      final Map<String, CartModel> loadedCartItems = {};

      for (final item in cartItems) {
        if (item is Map<String, dynamic>) {
          loadedCartItems.putIfAbsent(
            item['productId'] as String,
            () => CartModel(
              cartId: item['cartId'],
              productId: item['productId'],
              // Safely parse 'quantity' from String to int.
              quantity: int.tryParse(item['quantity']) ??
                  0, // Provide a default value in case of parsing failure.
            ),
          );
        }
      }

      _cartItems = loadedCartItems;
    } catch (e) {
      print('Error fetching cart: $e');
    }
    notifyListeners();
  }

  Future<void> removeFromCartFirebase({required String productId,required String cartId,required String quantity}) async {
    final User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      await userDB.doc(uid).update({
        'userCart': FieldValue.arrayRemove([
          {'productId': productId,
            'quantity':   quantity,
            'cartId': cartId,
          }
        ])
      });
      print('Cart removed from Firebase.');
      await fetchCart(); // Ensure the cart is updated after removing
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
      await fetchCart(); // Ensure the cart is updated after clearing
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

  // void addToCart({required String productId}) {
  //   _CartItems.putIfAbsent(
  //       productId, () => CartModel(
  //           cartId: const Uuid().v4(), quantity: 1, productId: productId));
  //           print('-----------------------------cart added repeatedly--------------------');
  //   notifyListeners();
  // }

  // void removeFromCart({required String productId}) {
  //   _cartItems.remove(productId);
  //   notifyListeners();
  // }

  // void clearCart() {
  //   _cartItems.clear();
  //   notifyListeners();
  // }

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
