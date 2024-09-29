import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/auth/providers/value_state_provider.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueStateProvider, SignInAndUpProvider>(
        builder: (context, valueProvider, signProvider, child) {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
          valueProvider.changeIsMailCorrect(true);
          signProvider.deleteControllerText();
        },
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE5F1FF),
              ),
              child: Image.asset(
                'assets/images/Back.png',
                width: 24,
              ),
            ),
            const Text(
              'Back',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xFF377DFF),
              ),
            )
          ],
        ),
      );
    });
  }
}
