import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/models/user_model.dart';
import 'package:talky_aplication_2/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/base/base_change_notifier.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/profile_state.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class SignInAndUpProvider extends BaseChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController inputCodeController = TextEditingController();

  FutureOr<void> signIn(BuildContext context) async {
    updateState(Statuses.loading);
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
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, NameRoutes.profile);
      });
      updateState(Statuses.completed);
    } on FirebaseAuthException catch (error) {
      final provider = Provider.of<ValueStateProvider>(context, listen: false);
      provider.changeIsMailCorrect(false);
      updateState(Statuses.error);
      print('Error :$error');
    }

    notifyListeners();
  }

  FutureOr<void> signUp() async {
    updateState(Statuses.loading);
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
        final userData = UserModel(
            email: user.email, id: user.uid, profileState: ProfileState.create);
        await FirebaseFirestore.instance
            .collection("User")
            .doc(user.uid)
            .set(userData.toJson());
        updateState(Statuses.completed);
      }
    } catch (e) {
      updateState(Statuses.error);
    }
  }

  FutureOr<bool> isRegistered() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: emailController.text)
        .get();
    return userDoc.docs.isNotEmpty;
  }

  void changeEmailPassword(String newEmail, String newPassword) {
    emailController.text = newEmail;
    passwordController.text = newPassword;
    notifyListeners();
  }
}
