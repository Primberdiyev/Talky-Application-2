import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';

class TalkyText extends StatelessWidget {
  const TalkyText({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Center(
        child: Text(
          locale.talky,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 60,
            color: Color(0xFF243443),
          ),
        ),
      ),
    );
  }
}
