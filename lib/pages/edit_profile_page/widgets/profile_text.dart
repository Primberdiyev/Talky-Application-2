import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  const ProfileText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: (MediaQuery.of(context).size.width) / 2 - 25,
      ),
      child: const Text(
        'Profile',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Color(0xFF243443),
        ),
      ),
    );
  }
}
