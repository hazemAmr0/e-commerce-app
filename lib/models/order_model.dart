import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String quantity;
  final String price;
  final String totalPrice;
  final String address;
  final String userName;
  final String ProductName;
  final String imageUrl;
  final String status;
  final Timestamp orderDate;

  OrderModel(
     {
      required this.price,
      required this.ProductName,
      required this.orderDate,
      required this.userName,
    required this.imageUrl,
    required this.orderId,  
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.address,
    
    required this.status,
  });
}