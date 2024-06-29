import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier{
  final String? productTitle;
  final String? productImage;
  final String? productPrice;
  final String? productDescription;
  final String? productCategory;
  final String? productId;
  final String? productQuantity;
  ProductModel(
      {this.productTitle,
      this.productImage,
      this.productPrice,
      this.productDescription,
      this.productCategory,
      this.productId,
      this.productQuantity});
}
