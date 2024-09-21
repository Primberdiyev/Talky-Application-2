import 'package:flutter/material.dart';

class CancelAndChatText extends StatelessWidget {
  const CancelAndChatText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Cancel',
          style: TextStyle(
              color: Color(0xFF377DFF),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFF243443),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        SizedBox.shrink(),
      ],
    );
  }
}
