import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/uaer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUser => userModel;

  Future<UserModel?> fetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    var uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userDocData = userDoc.data();
      if (userDocData != null) {
        userModel = UserModel(
          time: userDoc.get('timestamp'),
          name: userDoc.get('username'),
          email: userDoc.get('email'),
          uid: userDoc.get('uid'),
          profilePic: userDoc.get('image'),
          userCart: userDocData.containsKey('userCart')
              ? userDoc.get('userCart')
              : [],
          favorite: userDocData.containsKey('favorite')
              ? userDoc.get('favorite')
              : [],
        );
        notifyListeners(); // Notify listeners after updating userModel
        return userModel;
      }
    } catch (e) {
      print(e.toString()); // Consider a more robust error handling strategy
    }
    return null;
  }
}
