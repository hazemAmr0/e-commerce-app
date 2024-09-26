

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 List<ProductModel> _products=[];
List<ProductModel> get getProducts{

  return _products; 
} 

ProductModel? productsById(String productId) {
  return _products.firstWhere(
    (element) => element.productId == productId,
    
  );
}
List<ProductModel> productsByCategory(String category) {
    return _products
        .where((product) =>
            product.productCategory
                ?.toLowerCase()
                .contains(category.toLowerCase()) ??
            false)
        .toList();
  }
  final productDB=FirebaseFirestore.instance.collection('products');
  Stream<List<ProductModel>> FetchproductsStream(){

     try{
      return productDB.snapshots().map((snapshot){
      _products.clear();
      for (var doc in snapshot.docs) {
        _products.insert(0,ProductModel.fromSnapshot(doc));
      }
      return _products;
      });
    }catch(e){
      return Stream.empty();
     
    }

  }



  Future<void> addComment(String productId, String commentText) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _firestore
            .collection('products')
            .doc(productId)
            .collection('comments')
            .add({
          'commentText': commentText,
          'userId': user.uid,
          'timestamp': Timestamp.now(),
        });
        print('Comment added successfully');
      } else {
        print('User not logged in');
      }
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  Stream<QuerySnapshot> getComments(String productId) {
    return _firestore
        .collection('products')
        .doc(productId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      return userDoc.data();
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

}