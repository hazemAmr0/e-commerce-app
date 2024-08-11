import 'package:flutter/material.dart';

class FavoriteModel with  ChangeNotifier {
  final String productId;
final String favoriteId;
  FavoriteModel({required this.favoriteId,required this.productId});
}