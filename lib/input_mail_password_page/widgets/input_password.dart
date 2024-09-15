import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/routes/bool_value_enum.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: TextField(
          controller: provider.passwordController,
          obscureText: provider.isHideText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: !provider.isEmailCorrect
                    ? Colors.red
                    : const Color(0xFFAAB0B7),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: !provider.isEmailCorrect
                  ? Colors.red
                  : const Color(0xFFAAB0B7),
            )),
            suffixIcon: IconButton(
              onPressed: () {
                provider.changeBoolValue(BoolValueEnum.isHideText);
              },
              icon: Icon(!provider.isHideText
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            labelText: 'Enter your password',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: !provider.isEmailCorrect
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
