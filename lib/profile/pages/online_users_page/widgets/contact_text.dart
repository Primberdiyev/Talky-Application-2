import 'package:flutter/material.dart';

class ContactText extends StatelessWidget {
  const ContactText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Contacts',
          style: TextStyle(
            color: Color(0xFF243443),
            fontSize: 16,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}
