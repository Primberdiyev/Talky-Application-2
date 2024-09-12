import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TalkyProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController inputCodeController = TextEditingController();
  bool isSignIn = true;
  bool agreeCondition = false;
  bool isHideText = true;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
        appEmail: "dev.talky@gmail.com",
        appName: "TalkyApp",
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

  Future<void> signUp(BuildContext context) async {
    try {
      bool isVerified = EmailOTP.verifyOTP(otp: inputCodeController.text);

      if (!isVerified) {
        throw Exception('Invalid OTP. Please try again.');
      }

      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/AccountPage');
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
}
