import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{


   final Timestamp time; 
    final String name;
    final String email;
  final String uid;
  final String profilePic;
 final List userCart, favorite;

  UserModel({ required this.time,required this.name, required this.email, required this.uid, required this.profilePic, required this.userCart, required this.favorite});   
  
    
}