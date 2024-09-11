import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';

class SignUpButton extends StatelessWidget {
  SignUpButton({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 252,
          bottom: 30,
        ),
        child: InkWell(
          onTap: () async {
            provider.changeBoolValue('isLoading');
            await provider.signUp(context, provider.email, provider.password);
            provider.changeBoolValue('isLoading');
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 56,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF377DFF),
            ),
            child: Center(
              child: !provider.isLoading
                  ? const Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500),
                    )
                  : const CircularProgressIndicator(
                      color: Colors.white,
                    ),
            ),
          ),
        ),
      );
    });
  }
}
