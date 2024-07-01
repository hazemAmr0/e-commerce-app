import 'package:flutter/material.dart';

class FavoriteModel with  ChangeNotifier {
  final String productId;
final String id;
  FavoriteModel({required this.id,required this.productId});
}