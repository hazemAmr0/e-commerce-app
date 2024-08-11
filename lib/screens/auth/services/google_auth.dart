import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FirebaseServices{
final auth=FirebaseAuth.instance;
final googleSignIn=GoogleSignIn();

final firestore=FirebaseFirestore.instance;

Future<UserCredential?> signInWithGoogle( BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      // If googleUser is null, the user cancelled the sign-in process.
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    
UserCredential userCredential=await auth.signInWithCredential(credential);


  
   SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);

await firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': userCredential.user!.displayName,
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'timestamp': Timestamp.now(),
        'image': userCredential.user!.photoURL,
        'userCart': [],
        'favorite': [],

      }, 
      );


     
      // Attempt to sign in the user with the given credentials
      return userCredential; 
      
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           backgroundColor: Colors.red,
           content: Text(e.message.toString()),
         ),
       );
      return null;
    } catch (e) {
      // Handle other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
      return null;
    }
  }
  Future<void> Signout(BuildContext context) async {
    await googleSignIn.signOut();

    // Clear the cart using the CartProvider
    Provider.of<CartProvider>(context, listen: false).clearLocalCart();
        Provider.of<FavoriteProvider>(context, listen: false).clearLocalFavCart();


    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }
}