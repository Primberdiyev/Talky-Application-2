import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () async {
      final User? user = FirebaseAuth.instance.currentUser;
      final currentUser = await FirebaseFirestore.instance
          .collection('User')
          .doc(user?.uid)
          .get();
      if (currentUser.exists) {
        Navigator.pushReplacementNamed(context, NameRoutes.profile);
      } else {
        Navigator.pushReplacementNamed(context, NameRoutes.auth);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
