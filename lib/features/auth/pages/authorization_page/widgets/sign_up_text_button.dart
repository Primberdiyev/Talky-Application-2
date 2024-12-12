import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/utils/bool_value_enum.dart';

class SignUpTextButton extends StatefulWidget {
  const SignUpTextButton({super.key});

  @override
  State<SignUpTextButton> createState() => _SignUpTextButtonState();
}

class _SignUpTextButtonState extends State<SignUpTextButton> {
  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Consumer2<ValueStateProvider, SignInAndUpProvider>(
      builder: (
        context,
        valueProvider,
        controllerProvider,
        child,
      ) {
        return InkWell(
          onTap: () {
            valueProvider.changeBoolValue(BoolValueEnum.isSignIn);
            valueProvider.changeIsMailCorrect(true);
            Navigator.pushReplacementNamed(context, NameRoutes.auth);
          },
          child: Text(
            valueProvider.isSignIn
                ? locale.signUpHere
                : context.locale.signInhere,
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
