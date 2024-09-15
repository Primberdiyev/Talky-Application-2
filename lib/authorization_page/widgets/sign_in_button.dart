import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/routes/bool_value_enum.dart';
import 'package:talky_aplication_2/services/auth_service.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return Container(
        margin: const EdgeInsets.only(bottom: 38),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFFFFFFF),
        ),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : InkWell(
                onTap: () async {
                  provider.changeBoolValue(BoolValueEnum.isLoading);
                  await AuthService().signInWithGoogle(context);
                  provider.changeBoolValue(BoolValueEnum.isLoading);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 39, right: 38),
                      child: Image.asset(
                        'assets/images/iconGoogle-2.png',
                        width: 24,
                      ),
                    ),
                    Text(
                      provider.isSignIn
                          ? 'Sign in with Google'
                          : "Sign up with Google",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF263443),
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }
}
