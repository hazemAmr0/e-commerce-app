
import 'package:e_commerce_app/screens/auth/login_screen.dart';
import 'package:e_commerce_app/screens/auth/services/Auth_sevices.dart';
import 'package:e_commerce_app/screens/auth/services/google_auth.dart';

import 'package:flutter/material.dart';

Future<dynamic> logOutAlert(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: ()async {
                  await logoutUser(context);

                  },
                )
              ],
            ),
          ],
        );
      });
}
// Assuming this function is an async function inside a widget or a helper class
Future<void> logoutUser(BuildContext context) async {
  try {
    // Close any open dialogs or overlays before starting the logout process
    Navigator.of(context).pop();

    // Perform sign-out operations
    await FirebaseServices().Signout(context);
    await AuthServices().signOut(context);

    // Once sign-out is successful, show a single snack bar message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Logged out successfully!'),
      ),
    );

    // Navigate to the login screen after showing the snack bar
    // Ensure this is the last step to avoid UI glitches
    await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);  
  } catch (e) {
    // Handle errors that might occur during the logout process
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error logging out: $e'),
      ),
    );
  }
}
