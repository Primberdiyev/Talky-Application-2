import 'package:email_otp/email_otp.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class OtpProvider extends BaseChangeNotifier {
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
        updateState(Statuses.error);
        print('Error in check Otp');
        throw Exception("Failed to send OTP");
      }
    } catch (e) {
      updateState(Statuses.error);
      print("Failed to send OTP");
    }
  }
}
