import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';

class ContactText extends StatelessWidget {
  const ContactText({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        locale.contacts,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color:  Color(0xFF243443),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
