import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class CancelAndChatText extends StatelessWidget {
  const CancelAndChatText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, NameRoutes.main);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFF377DFF),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFF243443),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 55,
        ),
      ],
    );
  }
}
