import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'User.dart';

class UserManager{
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  Future<void> signIn(User user) async {
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.passworld);
      print(result.user.uid);
    } catch(e){
      print(e);
    }
  }
}