import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_auth_button.dart';
import 'package:talky_aplication_2/features/auth/providers/otp_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class SignInAndUpButton extends StatefulWidget {
  const SignInAndUpButton({
    super.key,
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  State<SignInAndUpButton> createState() => _SignInAndUpButtonState();
}

class _SignInAndUpButtonState extends State<SignInAndUpButton> {
  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Consumer3<OtpProvider, ValueStateProvider, SignInAndUpProvider>(
      builder: (
        context,
        otpProvider,
        valueProvider,
        authProvider,
        child,
      ) {
        if (valueProvider.isSignIn && authProvider.state.isCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted &&
                widget.email.isNotEmpty &&
                widget.password.isNotEmpty) {
              Navigator.pushReplacementNamed(context, NameRoutes.main);
              authProvider.updateState(Statuses.initial);
            }
          });
        }
        return CustomAuthButton(
          textFontSize: 18,
          textColor: Colors.white,
          text: valueProvider.isSignIn ? locale.signIn : locale.signUp,
          function: () {
            // authProvider.changeEmailPassword(
            //   email.trim(),
            //   password.trim(),
            // );
            if (valueProvider.isSignIn) {
              authProvider.signIn(
                email: widget.email,
                password: widget.password,
              );
            } else {
              if (valueProvider.agreeCondition) {
                otpProvider.sendOTP(email: widget.email).then((_) {
                  if (context.mounted && otpProvider.state.isCompleted) {
                    Navigator.pushNamed(
                      context,
                      NameRoutes.checkCode,
                      arguments: {
                        'email': widget.email,
                        'password': widget.password,
                      },
                    );
                  }
                });
              }
            }
          },
          isLoading: valueProvider.isSignIn
              ? authProvider.state.isLoading
              : otpProvider.state.isLoading,
          buttonColor: AppColors.primaryBlue,
        );
      },
    );
  }
}
