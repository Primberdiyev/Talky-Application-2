import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/unilities/bool_value_enum.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class TalkyProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController inputCodeController = TextEditingController();

  bool isSignIn = true;
  bool agreeCondition = false;
  bool isHideText = true;
  Statuses _state = Statuses.initial;
  Statuses get state => _state;
  bool isEmailCorrect = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void changeBoolValue(BoolValueEnum value) {
    switch (value) {
      case BoolValueEnum.isSignIn:
        isSignIn = !isSignIn;
        break;
      case BoolValueEnum.agreeCondition:
        agreeCondition = !agreeCondition;
        break;
      case BoolValueEnum.isHideText:
        isHideText = !isHideText;
        break;
    }

    notifyListeners();
  }

  void deleteControllerText() {
    emailController.clear();
    passwordController.clear();
    inputCodeController.clear();
    notifyListeners();
  }

  Future<void> sendOTP({required String email}) async {
    updateState(Statuses.loading);
    try {
      EmailOTP.config(
        appName: 'Talky',
        otpType: OTPType.numeric,
        expiry: 30000,
        emailTheme: EmailTheme.v6,
        appEmail: 'dev.talky@gmail.com',
        otpLength: 4,
      );

      bool result = await EmailOTP.sendOTP(email: email);
      updateState(Statuses.completed);

      if (!result) {
        throw Exception("Failed to send OTP");
      }
    } catch (e) {
      updateState(Statuses.error);
      throw Exception(e.toString());
    }
  }

  FutureOr<void> signIn(BuildContext context) async {
    final provider = Provider.of<ProfilePageProvider>(context, listen: false);
    updateState(Statuses.loading);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        provider.updateCurrentUser(user);
      }

      changeIsMailCorrect(true);
      Navigator.pushNamed(context, NameRoutes.profile);
      deleteControllerText();
      updateState(Statuses.completed);
    } on FirebaseAuthException catch (_) {
      updateState(Statuses.error);
      changeIsMailCorrect(false);
    }

    notifyListeners();
  }

  FutureOr<void> signUp(BuildContext context) async {
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
        await FirebaseFirestore.instance.collection("User").doc(user.uid).set({
          'email': user.email,
          'id': user.uid,
        });
      }
      final provider = Provider.of<ProfilePageProvider>(context, listen: false);
      provider.updateCurrentUser(user);

      Navigator.pushReplacementNamed(context, NameRoutes.accout);
      updateState(Statuses.completed);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      updateState(Statuses.error);
    }
    deleteControllerText();
  }

  void changeEmailPassword(String newEmail, String newPassword) {
    emailController.text = newEmail;
    passwordController.text = newPassword;
    notifyListeners();
  }

  FutureOr<bool> isRegistered() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: emailController.text)
        .get();
    return userDoc.docs.isNotEmpty;
  }

  changeIsMailCorrect(bool newValue) {
    isEmailCorrect = newValue;
    notifyListeners();
  }

  void updateState(Statuses value) {
    _state = value;
    notifyListeners();
  }
}
