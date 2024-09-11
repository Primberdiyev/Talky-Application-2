import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';

class InputMail extends StatelessWidget {
  const InputMail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: TextField(
          controller: provider.emailController,
          decoration: const InputDecoration(
            labelText: 'Enter your mail address',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFFAAB0B7),
            ),
            border: OutlineInputBorder(),
          ),
        ),
      );
    });
  }
}
