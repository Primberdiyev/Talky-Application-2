import 'package:flutter/material.dart';

class CompleteButton extends StatelessWidget {
  const CompleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 163, right: 28),
      child: TextButton(
        style: TextButton.styleFrom(
            fixedSize: const Size(394, 54),
            backgroundColor: const Color(0xFF377DFF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: () async {},
        child: const Text(
          'Complete',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
