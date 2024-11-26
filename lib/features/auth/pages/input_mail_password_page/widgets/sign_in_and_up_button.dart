import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_auth_button.dart';
import 'package:talky_aplication_2/features/auth/providers/otp_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';
import 'package:talky_aplication_2/unilities/bool_value_enum.dart';

class SignInAndUpButton extends StatelessWidget {
  const SignInAndUpButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Consumer3<OtpProvider, ValueStateProvider, SignInAndUpProvider>(
      builder: (
        context,
        otpProvider,
        valueProvider,
        authProvider,
        child,
      ) {
        if (valueProvider.isSignIn && authProvider.state.isCompleted) {
          Future.delayed(Duration.zero, () {
            if (context.mounted &&
                emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty) {
              Navigator.pushReplacementNamed(context, NameRoutes.main);
            }
          });
        }
        if (!valueProvider.isSignIn && otpProvider.state.isCompleted) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              Navigator.pushNamed(context, NameRoutes.checkCode);
            }
          });
        }
        return CustomAuthButton(
          textFontSize: 18,
          textColor: Colors.white,
          text: valueProvider.isSignIn ? "Sign in" : "Sign up",
          function: () {
            authProvider.changeEmailPassword(
              emailController.text,
              passwordController.text,
            );
            if (valueProvider.isSignIn) {
              authProvider.signIn();
            } else {
              if (valueProvider.agreeCondition) {
                otpProvider.sendOTP(email: emailController.text);

                valueProvider.changeBoolValue(BoolValueEnum.agreeCondition);
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
