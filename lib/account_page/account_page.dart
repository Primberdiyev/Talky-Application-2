import 'package:flutter/material.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, NameRoutes.auth);
            },
            child: const Text('Go To Register page')),
      ),
    );
  }
}
