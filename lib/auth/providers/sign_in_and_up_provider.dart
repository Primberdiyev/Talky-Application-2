import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/models/auth_user_model.dart';
import 'package:talky_aplication_2/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class SignInAndUpProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController inputCodeController = TextEditingController();

  FutureOr<void> signIn(BuildContext context) async {
    final provider = Provider.of<ProfilePageProvider>(context, listen: false);
    final signProvider =
        Provider.of<ValueStateProvider>(context, listen: false);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        provider.updateCurrentUser(user);
      }

      signProvider.changeIsMailCorrect(true);
      Navigator.pushNamed(context, NameRoutes.profile);
      deleteControllerText();
    } on FirebaseAuthException catch (_) {
      final provider = Provider.of<ValueStateProvider>(context, listen: false);
      provider.changeIsMailCorrect(false);
    }

    notifyListeners();
  }

  FutureOr<void> signUp(BuildContext context) async {
    try {
      bool isVerified = EmailOTP.verifyOTP(otp: inputCodeController.text);

      if (!isVerified) {
        throw Exception('Invalid OTP. Please try again.');
      }
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      User? user = userCredential.user;
      if (user != null) {
        final userData = AuthUserModel(email: user.email, id: user.uid);
        await FirebaseFirestore.instance
            .collection("User")
            .doc(user.uid)
            .set(userData.toJson());
      }
      final provider = Provider.of<ProfilePageProvider>(context, listen: false);
      provider.updateCurrentUser(user);

      Navigator.pushReplacementNamed(context, NameRoutes.accout);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    deleteControllerText();
  }

  FutureOr<bool> isRegistered() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: emailController.text)
        .get();
    return userDoc.docs.isNotEmpty;
  }

  void deleteControllerText() {
    emailController.clear();
    passwordController.clear();
    inputCodeController.clear();
    notifyListeners();
  }

  void changeEmailPassword(String newEmail, String newPassword) {
    emailController.text = newEmail;
    passwordController.text = newPassword;
    notifyListeners();
  }
}
