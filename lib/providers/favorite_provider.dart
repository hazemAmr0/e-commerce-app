import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/favorite_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FavoriteProvider with ChangeNotifier {
  Map<String, FavoriteModel> _favoriteItems = {};
  Map<String, FavoriteModel> get getFavorites => _favoriteItems;

  bool isProductFavorite({required String productId}) {
    return _favoriteItems.containsKey(productId);
  }

  // Firebase
  final userDB = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  Future<void> addToFavoriteFirebase({
    required String productId,
    required BuildContext context,
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
    final favoriteId = const Uuid().v4();
    try {
      await userDB.doc(uid).update({
        'favorite': FieldValue.arrayUnion([
          {'favoriteId': favoriteId, 'productId': productId}
        ])
      });
      print('Favorite added to Firebase.');

       fetchFavoritesStream(); // Ensure the favorites list is updated after adding
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }
  }

  Stream<void> fetchFavoritesStream() {
    final User? user = auth.currentUser;
    if (user == null) {
      return Stream.value(null);
    }

    return userDB.doc(user.uid).snapshots().map((userDoc) {
      final data = userDoc.data();
      if (data == null || !data.containsKey("favorite")) {
        _favoriteItems.clear();
        notifyListeners();
        return;
      }

      final List<dynamic> favoriteItems = data['favorite'] as List<dynamic>;
      final Map<String, FavoriteModel> loadedFavoriteItems = {};

      for (final item in favoriteItems) {
        if (item is Map<String, dynamic>) {
          loadedFavoriteItems.putIfAbsent(
            item['productId'] as String,
            () => FavoriteModel(
              favoriteId: item['favoriteId'],
              productId: item['productId'],
            ),
          );
        }
      }

      _favoriteItems = loadedFavoriteItems;
      notifyListeners();
    });
  }
  Future<void> removeFromFavoriteFirebase({
    required String productId,
    required String favoriteId,
  }) async {
    final User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      await userDB.doc(uid).update({
        'favorite': FieldValue.arrayRemove([
          {'productId': productId, 'favoriteId': favoriteId}
        ])
      });
      print('Favorite removed from Firebase.');
       fetchFavoritesStream(); // Ensure the favorites list is updated after removing
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  Future<void> clearFavoritesFirebase() async {
    final User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      await userDB.doc(uid).update({'favorite': []});
      print('Favorites cleared from Firebase.');
      await fetchFavoritesStream(); // Ensure the favorites list is updated after clearing
    } catch (e) {
      print('Error clearing favorites: $e');
    }
  }
     void clearLocalFavCart() {
    _favoriteItems.clear();
    notifyListeners();
  }
}
