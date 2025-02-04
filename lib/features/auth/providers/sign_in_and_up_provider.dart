import 'dart:async';
import 'dart:developer';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/utils/profile_state.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class SignInAndUpProvider extends BaseChangeNotifier {
  final UserDataService userDataService = UserDataService.instance;
  // String _email = '';
  // String _password = '';
  // String get email => _email;
  // String get password => _password;

  FutureOr<User?> signIn({
    required String email,
    required String password,
  }) async {
    updateState(Statuses.loading);

    try {
      final UserCredential userCredential =
          await userDataService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      updateState(Statuses.completed);
      return user;
    } on FirebaseAuthException catch (error) {
      updateState(Statuses.error);
      log('Error :$error');
      return null;
    }
  }

  FutureOr<void> signUp(
    TextEditingController controller,
    String newEmail,
    String newPassword,
  ) async {
    updateState(Statuses.loading);
    try {
      final isVerified = EmailOTP.verifyOTP(otp: controller.text);

      if (!isVerified) {
        throw Exception('Invalid OTP. Please try again.');
      }

      final userCredential =
          await userDataService.auth.createUserWithEmailAndPassword(
        email: newEmail,
        password: newPassword,
      );

      final user = userCredential.user;

      if (user != null) {
        final userData = UserModel(
          email: user.email,
          id: user.uid,
          profileState: ProfileState.create,
        );
        await UserDataService.instance.setUserDoc(userData.toJson());

        updateState(Statuses.completed);
      }
    } catch (e) {
      log('error on sign up $e');
      updateState(Statuses.error);
    }
  }

  // FutureOr<bool> isRegistered() async {
  //   return userDataService.isRegistered(email);
  // }

  // void changeEmailPassword(String newEmail, String newPassword) {
  //   _email = newEmail;
  //   _password = newPassword;
  //   notifyListeners();
  // }
}
