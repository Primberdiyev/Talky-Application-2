import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class TalkyProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController inputCodeController = TextEditingController();
  bool isSignIn = true;
  bool agreeCondition = false;
  bool isHideText = true;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isEmailCorrect = true;

  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  final EmailOTP emailOtp = EmailOTP();

  void changeBoolValue(String value) {
    switch (value) {
      case "isSignIn":
        isSignIn = !isSignIn;
        break;
      case "agreeCondition":
        agreeCondition = !agreeCondition;
        break;
      case "isHideText":
        isHideText = !isHideText;
        break;
      case "isLoading":
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

  signIn(BuildContext context) async {
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

  signUp(BuildContext context) async {
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

  Future<bool> isRegistered() async {
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
}
