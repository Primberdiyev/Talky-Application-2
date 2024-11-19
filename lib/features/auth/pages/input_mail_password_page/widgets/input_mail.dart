import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';

class InputMail extends StatefulWidget {
  const InputMail({super.key});

  @override
  State<InputMail> createState() => _InputMailState();
}

class _InputMailState extends State<InputMail> {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter email';
    }
    final emailPattern = RegExp(r'^[\w-]+@[a-zA-Z]+\.[a-zA-Z]+');
    if (!emailPattern.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueStateProvider, SignInAndUpProvider>(
      builder: (context, valuProvider, signProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 40),
          child: TextFormField(
            validator: validateEmail,
            controller: signProvider.emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !valuProvider.isEmailCorrect
                      ? Colors.red
                      : const Color(0xFFAAB0B7),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !valuProvider.isEmailCorrect
                      ? Colors.red
                      : const Color(0xFFAAB0B7),
                ),
              ),
              labelText: 'Enter your mail address',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: !valuProvider.isEmailCorrect
                    ? Colors.red
                    : const Color(0xFFAAB0B7),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}
