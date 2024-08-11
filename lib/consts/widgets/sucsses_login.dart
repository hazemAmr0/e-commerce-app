import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showSuccessLoginAndNavigateToHome(BuildContext context,) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dialog from closing on tap outside
    builder: (BuildContext context) {
      return AlertDialog(
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
              onLoaded: (composition) {
                // Set the duration of the animation
                
                // Wait for the duration of the animation
                Future.delayed(composition.duration).then((_) {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.rootScreen); // Navigate to home screen
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Login Success!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
           
            const SizedBox(height: 24.0),
          ],
        ),
      );
    },
  );
}
