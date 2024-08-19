import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];
  List<OrderModel> get getOrders => _orders;

  Future<List<OrderModel>> fetchOrder() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return []; // Return empty list if user is not authenticated
    }
    final uid = user.uid;

    try {
      final orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(uid) // Reference the document corresponding to the user's uid
          .collection('userOrders') // Reference the user's orders subcollection
          .get();

      _orders.clear();
      for (var element in orderSnapshot.docs) {
        _orders.add(OrderModel(
          orderDate: element.get('orderDate'),
          address: element.get('address'),
          status: element.get('orderStatus'),
          totalPrice: element.get('totalPrice').toString(),
          orderId: element.get('orderId'),
          productId: element.get('productId'),
          userId: element.get('userId'),
          price: element.get('price').toString(),
          ProductName: element.get('product title').toString(),
          quantity: element.get('quantity').toString(),
          imageUrl: element.get('imageUrl'),
          userName: element.get('username'),
        ));
      }

      //notifyListeners();
      return _orders;
    } catch (e) {
      print('Error fetching orders: $e');
      rethrow;
    }
  }
}
