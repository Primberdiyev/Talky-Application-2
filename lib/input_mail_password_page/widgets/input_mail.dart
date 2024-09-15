import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';

class InputMail extends StatefulWidget {
  final formKey;
  const InputMail({super.key, required this.formKey});

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
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Form(
          key: widget.formKey,
          child: TextFormField(
            validator: validateEmail,
            controller: provider.emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: !provider.isEmailCorrect
                      ? Colors.red
                      : const Color(0xFFAAB0B7),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: !provider.isEmailCorrect
                      ? Colors.red
                      : const Color(0xFFAAB0B7),
                ),
              ),
              labelText: 'Enter your mail address',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: !provider.isEmailCorrect
                    ? Colors.red
                    : const Color(0xFFAAB0B7),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }
}
