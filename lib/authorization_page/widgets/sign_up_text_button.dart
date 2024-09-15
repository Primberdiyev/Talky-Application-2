import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/routes/bool_value_enum.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class SignUpTextButton extends StatelessWidget {
  const SignUpTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: () {
          provider.changeBoolValue(BoolValueEnum.isLoading);
          provider.deleteControllerText();
          provider.changeIsMailCorrect(true);
          Navigator.pushReplacementNamed(context, NameRoutes.auth);
        },
        child: Text(
          provider.isSignIn ? 'Sign up here' : "Sign in here",
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(0xFF377DFF),
          ),
        ),
      );
    });
  }
}
