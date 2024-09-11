import 'package:flutter/material.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 20, bottom: 44),
        child: Text(
          'Forgot password?',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF243443)),
        ),
      ),
    );
  }
}
