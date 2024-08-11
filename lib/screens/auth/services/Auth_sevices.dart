import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices{
  
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUp({required String email, required String password, required String username,
      required List favorite,required List userCart,required String image ,required Timestamp timestamp,required BuildContext context}) async {
    String res = ' some error';
    try {
   
       UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password); 
       await firestore.collection('users').doc(user.user!.uid).set({
         'username': username,
         'uid': user.user!.uid,
         'email': email,
         'timestamp': timestamp,
         'image': image,
         'userCart': userCart,
         'favorite': favorite,


         

       });
        res='user created';


      
    } on FirebaseAuthException catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.message.toString()),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

   Future<String> signIn(
      String email, String password, BuildContext context) async {
    String res = 'Some error occurred';
    try {
      // Attempt to sign in with email and password
      // ignore: unused_local_variable
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      res = 'user Logged in successfully';

      // Save login state to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      _showErrorSnackBar(context, 'Invalid email or password');
    } catch (e) {
      print(e.toString());
      _showErrorSnackBar(context, 'An error occurred. Please try again later.');
    }

    return res;
  }
 Future<void> signOut(BuildContext context) async {
    await _auth.signOut();

    // Assuming you have access to your CartProvider here. Adjust based on your state management solution.
    Provider.of<CartProvider>(context, listen: false).clearLocalCart();
    Provider.of<FavoriteProvider>(context, listen: false).clearLocalFavCart();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }
  Future<String> resetPassword(String email) async {
    String res = 'some error';
    try {
      await _auth.sendPasswordResetEmail(email: email);
      res = 'check your email';
    } catch (e) {
      res = e.toString();
    }
    return res;

  } 
   void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }
  
}
