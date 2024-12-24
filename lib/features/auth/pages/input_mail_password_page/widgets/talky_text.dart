import 'package:flutter/material.dart';

class TalkyText extends StatelessWidget {
  const TalkyText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Talky',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 40,
        color: Color(0xFF243443),
      ),
    );
  }
}
