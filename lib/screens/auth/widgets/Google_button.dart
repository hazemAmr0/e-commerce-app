import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/screens/auth/services/google_auth.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
                                onTap: () async {
  // Debug log to indicate the method is called
  print('Google sign-in button tapped');
  try {
    final userCredential = await FirebaseServices().signInWithGoogle(context);
    if (userCredential != null) {
      print('Signed in successfully');
    Navigator.pushReplacementNamed(context, Routes.rootScreen);
      // Update your UI or state accordingly
    } else {
      print('Sign-in was cancelled or failed');
    }
  } catch (e) {
    print('Error during sign-in: $e');
  }
},
                                child: Image.asset(
                                  'assets/images/google.png',
                                ),
                              );
  }
}