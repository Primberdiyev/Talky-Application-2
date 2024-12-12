import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';

class EnterCodeText extends StatelessWidget {
  const EnterCodeText({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Text(
      locale.enterDigit,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF243443),
        fontSize: 18,
      ),
    );
  }
}
