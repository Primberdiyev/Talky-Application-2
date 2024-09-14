import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
          provider.changeIsMailCorrect(true);
          provider.deleteControllerText();
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
