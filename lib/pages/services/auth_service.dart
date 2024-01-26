import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //foydalanuvchini ro`yhatdan o`tkizish

  static Future<User?> registerUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // ignore: use_build_context_synchronously
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$e")));
      });
    }
    return null;
  }

  static Future<User?> loginUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } catch (e) {
      // ignore: use_build_context_synchronously
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$e")));
      });
    }
    return null;
  }

  static Future<void> deleteAccount() async {
    await auth.currentUser?.delete();
  }

  static Future<void> logOutAcc() async {
    await auth.signOut();
  }
}
