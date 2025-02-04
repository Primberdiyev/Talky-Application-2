import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
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

    return Consumer<ValueStateProvider>(
      builder: (
        context,
        valueProvider,
        child,
      ) {
        return InkWell(
          onTap: () {
            valueProvider.changeBoolValue(BoolValueEnum.isSignIn);
            valueProvider.changeIsMailCorrect(true);
            Future.delayed(Duration.zero, () {
              if (context.mounted) {
                Navigator.pushReplacementNamed(
                  context,
                  NameRoutes.inputMailPassword,
                );
              }
            });
          },
          child: Text(
            textAlign: TextAlign.center,
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
