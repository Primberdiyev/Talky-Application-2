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
    return Consumer2<OtpProvider, ValueStateProvider>(
      builder: (
        context,
        otpProvider,
        valueProvider,
        child,
      ) {
        return Consumer<SignInAndUpProvider>(builder: (
          context,
          authProvider,
          child,
        ) {
          return CustomAuthButton(
            textFontSize: 18,
            textColor: Colors.white,
            text: valueProvider.isSignIn ? "Sign in" : "Sign up",
            function: () async {
              final signProvider = context.read<SignInAndUpProvider>();
              signProvider.changeEmailPassword(emailController.text, passwordController.text);

              if (valueProvider.isSignIn) {
                try {
                  final authProvider = context.read<SignInAndUpProvider>();
                  final user = await authProvider.signIn();

                  valueProvider.changeIsMailCorrect(
                    emailController.text.isNotEmpty && passwordController.text.isNotEmpty,
                  );
                  if (user != null && valueProvider.isEmailCorrect) {
                    Navigator.pushReplacementNamed(context, NameRoutes.main);
                  }
                } catch (_) {
                  final provider = Provider.of<ValueStateProvider>(context, listen: false);
                  provider.changeIsMailCorrect(false);
                }
              } else {
                if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                  await otpProvider.sendOTP(email: emailController.text);

                  Future.delayed(Duration.zero, () {
                    Navigator.pushNamed(context, NameRoutes.checkCode);
                  });
                  valueProvider.changeBoolValue(BoolValueEnum.agreeCondition);
                }
              }
            },
            isLoading: valueProvider.isSignIn ? authProvider.state.isLoading : otpProvider.state.isLoading,
            buttonColor: AppColors.primaryBlue,
          );
        });
      },
    );
  }
}
