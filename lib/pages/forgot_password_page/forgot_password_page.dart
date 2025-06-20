import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Enter email to send you password reset email'),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Email',
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.yellow,
              fixedSize: const Size(200, 30),
            ),
            onPressed: () {
              AuthService().sendPasswordresetLink(_emailController.text);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link has Sended')));
              Navigator.pushReplacementNamed(context, NameRoutes.auth);
            },
            child: const Text(
              'Send',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
