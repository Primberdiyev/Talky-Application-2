import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/unilities/bool_value_enum.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueStateProvider,SignInAndUpProvider>(builder: (context, valueProvider,signProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: TextField(
          controller: signProvider.passwordController,
          obscureText: valueProvider.isHideText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: !valueProvider.isEmailCorrect
                    ? Colors.red
                    : const Color(0xFFAAB0B7),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: !valueProvider.isEmailCorrect
                  ? Colors.red
                  : const Color(0xFFAAB0B7),
            )),
            suffixIcon: IconButton(
              onPressed: () {
                valueProvider.changeBoolValue(BoolValueEnum.isHideText);
              },
              icon: Icon(!valueProvider.isHideText
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            labelText: 'Enter your password',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: !valueProvider.isEmailCorrect
                  ? Colors.red
                  : const Color(0xFFAAB0B7),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      );
    });
  }
}
