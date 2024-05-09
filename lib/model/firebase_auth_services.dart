import 'package:firebase_auth/firebase_auth.dart';
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
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // проверка на правильность логина и пароля
      if (e.code == "user-not-found" || e.code == "wrong-password") {
        showToast(message: "Invalid email or password.");
      } else {
        print(e.code);
        showToast(message: "An error occured ${e.code}");
      }
    }
    return null;
  }
}
