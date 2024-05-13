import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/toast.dart';

class FireBaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

// создание нового пользователя
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Проверка существующего email
      if (e.code == "email-already-in-use") {
        showToast(message: "The email is already in use.");
      } else {
        showToast(message: "An error occured ${e.code}");
      }
    }
    return null;
  }

// вход пользователя
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // проверка на заполненость полей
      if (email.isEmpty || password.isEmpty) {
        showToast(
            message: "Please fill in all fields.",
            backgroundColor: Colors.green);
        return null;
      }
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // проверка на правильность логина и пароля
      if (e.code == "invalid-email" ||
          e.code == "auth/wrong-password" ||
          e.code == "invalid-credential") {
        showToast(message: "Invalid email or password.");
      } else {
        // print(e.code);
        showToast(message: "An error occured ${e.code}");
      }
    }
    return null;
  }
}
