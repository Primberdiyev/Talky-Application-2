import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class MailButton extends StatelessWidget {
  const MailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 56),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFFFFFFF),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, NameRoutes.inputMailPassword);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 39, right: 38),
              child: Image.asset(
                'assets/images/mail.png',
                width: 24,
              ),
            ),
            const Text(
              'Continue with Mail',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF263443),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
