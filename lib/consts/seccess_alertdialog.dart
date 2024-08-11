

 import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future <void> showSuccessDialog(BuildContext context, String message) async{
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
              'assets/animation/done.json',
              height: 100,
              width: 100,
            repeat: false,
            ),
            
              SizedBox(height: 16.0),
              Text(
                'Success!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text('OKAY',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }

showRemoveAllItemsDialog(BuildContext context, CartProvider cartprovider) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remove All Items'),
        content:
            Text('Are you sure you want to remove all items from your cart?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Remove'),
            onPressed: () {
              // Code to remove all items from the cart
              cartprovider.clearCartFirebase();
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
