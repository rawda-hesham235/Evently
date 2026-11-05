import 'package:evently/core/firebase_function.dart';
import 'package:evently/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;
  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      intiUser();
    }
  }

  void intiUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    userModel = await FirebaseFunction.readUser(firebaseUser!.uid);
    notifyListeners();
  }
}
