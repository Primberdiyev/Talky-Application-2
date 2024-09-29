import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

class OtpProvider with ChangeNotifier {
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
}
