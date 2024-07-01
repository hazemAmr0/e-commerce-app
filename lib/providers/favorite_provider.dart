import 'package:e_commerce_app/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FavoriteProvider with ChangeNotifier {

  Map<String, FavoriteModel> _favoriteItems = {};

  Map<String, FavoriteModel> get favoriteItems => _favoriteItems;
  bool  isFavorite(String productId) => _favoriteItems.containsKey(productId);

void addOrRemovefromFavorite( {required String productId}) {
  if (_favoriteItems.containsKey(productId)) {
    _favoriteItems.remove(productId);
  } else {
    _favoriteItems.putIfAbsent(productId, () => FavoriteModel(
      id: Uuid().v4(),
      productId: productId,

    ));
  }
  notifyListeners();
}


  void clearFavorite() {
    _favoriteItems.clear(); 
    notifyListeners();
  }

}