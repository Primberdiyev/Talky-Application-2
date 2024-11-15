import 'package:flutter/material.dart';
import 'package:talky_aplication_2/unilities/app_texts.dart';

class ContactText extends StatelessWidget {
  const ContactText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppTexts.contacts,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Color(0xFF243443),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
