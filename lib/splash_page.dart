import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, NameRoutes.auth);
    });
    return const Scaffold(
      backgroundColor: AppColors.splashColor,
      body: Center(
        child: Text(
          'Talky',
          style: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
