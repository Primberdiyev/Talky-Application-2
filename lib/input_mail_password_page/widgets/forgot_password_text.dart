import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 44),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, NameRoutes.forgotPassword);
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF243443)),
          ),
        ),
      ),
    );
  }
}
