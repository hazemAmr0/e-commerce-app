import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, { required String message ,required Color color }){ 
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
    ),
  );
}
