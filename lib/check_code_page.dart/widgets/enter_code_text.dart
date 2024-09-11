import 'package:flutter/material.dart';

class EnterCodeText extends StatelessWidget {
  const EnterCodeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Enter the 4 digit codes we send to you',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF243443),
        fontSize: 18,
      ),
    );
  }
}
