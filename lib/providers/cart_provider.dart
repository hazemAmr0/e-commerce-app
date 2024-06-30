import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _CartItems = {};
  Map<String, CartModel> get getcart => _CartItems;

  bool IsProductInCart( {required String productId}) {
    return _CartItems.containsKey(productId);
  }

  void addToCart({required String productId}) {
    _CartItems.putIfAbsent(
        productId, () => CartModel(Uuid().v4(), 1, productId: productId));
    notifyListeners();
  }

  void removeFromCart({required String productId}) {
    _CartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _CartItems.clear();
    notifyListeners();
  }

  void updateQuantity({required String productId, required int quantity}) {
    _CartItems.update(
        productId,
        (value) => CartModel(value.cartId, quantity, productId: productId));
    notifyListeners();
  }

 double  totalAmount({required ProductProvider productProvider}) {
    double total = 0.0;
    _CartItems.forEach((key, cartItem) {
      final product = productProvider.productsById(cartItem.productId);
      if (product != null) {
        total += double.parse(product.productPrice!) * cartItem.quantity;
      }

    });

    return total;
  }
  int totalItems() {
    int total = 0;
    _CartItems.forEach((key, cartItem) {
     total += cartItem.quantity;
    
    });
    
return total;
  }


}