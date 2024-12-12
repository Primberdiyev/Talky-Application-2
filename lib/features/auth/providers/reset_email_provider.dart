import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';

class ResetEmailProvider with ChangeNotifier {
  final auth = UserDataService.instance.auth;
  Future<void> sendPasswordresetLink(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception();
    }
  }
}
