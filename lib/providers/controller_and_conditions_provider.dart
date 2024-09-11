import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TalkyProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController inputCodeController = TextEditingController();
  bool isSignIn = true;
  bool agreeCondition = false;
  bool isHideText = true;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(); // GoogleSignIn instansiyasini yaratish
  User? _user;
  String email = '';
  String password = '';

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  final EmailOTP emailOtp = EmailOTP();

  TalkyProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

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
    notifyListeners();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User canceled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check if the user is already registered
        final email = user.email;
        List methods = await _auth.fetchSignInMethodsForEmail(email!);
        print("isbot $methods");
        if (methods.isEmpty) {
          // User is registered, navigate to account page
          Navigator.pushReplacementNamed(context, '/accountPage');
        } else {
          // User is not registered, send OTP and navigate to check code page
          await sendOTP(email: emailController.text);
          Navigator.pushReplacementNamed(context, '/checkCodePage');
        }
      }
    } catch (e) {
      // Handle error, maybe show a Snackbar or Dialog
      print("Error during Google Sign-In: $e");
    }
  }

  Future<void> sendOTP({required String email}) async {
    try {
      // Configure EmailOTP
      EmailOTP.config(
        appEmail: "dev.talky@gmail.com",
        appName: "TalkyApp",
        otpLength: 4,
      );

      // Send OTP
      bool result = await EmailOTP.sendOTP(email: email);
      if (!result) {
        throw Exception("Failed to send OTP");
      }
    } catch (e) {
      // Handle error, maybe show a Snackbar or Dialog
      print("Error in sending OTP: $e");
    }
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      bool isVerified = EmailOTP.verifyOTP(otp: inputCodeController.text);

      if (!isVerified) {
        throw Exception('Invalid OTP. Please try again.');
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacementNamed(context, '/AccountPage');
    } catch (e) {
      // Handle error, maybe show a Snackbar or Dialog
      print("Error in sign up: $e");
    }
  }

  void changeEmailPassword(String newEmail, String newPassword) {
    email = newEmail;
    password = newPassword;
    notifyListeners();
  }
}
