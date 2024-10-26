import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';

class QuestionText extends StatelessWidget {
  const QuestionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ValueStateProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Center(
          child: Text(
            provider.isSignIn
                ? 'Don’t have an account?'
                : "Already have an account?",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF243443),
            ),
          ),
        ),
      );
    });
  }
}
