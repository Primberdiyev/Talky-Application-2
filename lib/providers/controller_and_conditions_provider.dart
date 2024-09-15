import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/bool_value_enum.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class TalkyProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController inputCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isSignIn = true;
  bool agreeCondition = false;
  bool isHideText = true;
  bool isLoading = false;
  bool isEmailCorrect = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? image;
  UploadTask? uploadTask;

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
      case BoolValueEnum.isLoading:
        isLoading = !isLoading;
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
      if (!result) {
        throw Exception("Failed to send OTP");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  FutureOr<void> signIn(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      changeIsMailCorrect(true);
      Navigator.pushNamed(context, NameRoutes.accout);
      deleteControllerText();
    } on FirebaseAuthException catch (_) {
      changeIsMailCorrect(false);
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
        await FirebaseFirestore.instance.collection("User").doc(user.uid).set({
          'email': user.email,
          'name': user.displayName ?? '',
          'imgUrl:': user.photoURL ?? '',
          'id': user.uid,
        });
      }

      Navigator.pushReplacementNamed(context, NameRoutes.accout);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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

  updateImage(newImage) {
    image = File(newImage.path);
    notifyListeners();
  }
}
