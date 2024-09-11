import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/homePage');
    });
    return const Scaffold(
      backgroundColor: Color(0xFF377DFF),
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
