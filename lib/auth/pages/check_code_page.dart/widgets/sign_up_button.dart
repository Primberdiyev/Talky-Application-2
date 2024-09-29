import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/unilities/bool_value_enum.dart';

class SignUpButton extends StatelessWidget {
  SignUpButton({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueStateProvider, SignInAndUpProvider>(
        builder: (context, valueProvider, googleProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 252,
          bottom: 30,
        ),
        child: InkWell(
          onTap: () async {
            valueProvider.changeBoolValue(BoolValueEnum.isLoading);
            await googleProvider.signUp(context);
            valueProvider.changeBoolValue(BoolValueEnum.isLoading);
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 56,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF377DFF),
            ),
            child: Center(
              child: !valueProvider.isLoading
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
