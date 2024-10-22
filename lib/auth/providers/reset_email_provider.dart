import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetEmailProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendPasswordresetLink(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception();
    }
  }
}
