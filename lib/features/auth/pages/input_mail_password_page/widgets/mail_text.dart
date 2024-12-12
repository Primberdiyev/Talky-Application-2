import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';

class MailText extends StatelessWidget {
  const MailText({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Consumer<ValueStateProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Text(
          provider.isSignIn ? locale.signInMail : locale.signUpMail,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(0xFF243443),
          ),
        );
      },
    );
  }
}
