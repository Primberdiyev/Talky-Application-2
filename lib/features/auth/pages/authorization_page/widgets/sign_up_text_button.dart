import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/app_texts.dart';
import 'package:talky_aplication_2/unilities/bool_value_enum.dart';

class SignUpTextButton extends StatelessWidget {
  const SignUpTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueStateProvider, SignInAndUpProvider>(
      builder: (context, valueProvider, controllerProvider, child) {
        return InkWell(
          onTap: () {
            valueProvider.changeBoolValue(BoolValueEnum.isSignIn);
            valueProvider.changeIsMailCorrect(true);
            Navigator.pushReplacementNamed(context, NameRoutes.auth);
          },
          child: Text(
            valueProvider.isSignIn ? AppTexts.signUpHere : AppTexts.signInhere,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF377DFF),
            ),
          ),
        );
      },
    );
  }
}
