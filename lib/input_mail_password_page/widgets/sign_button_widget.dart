import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class SignButtonWidget extends StatefulWidget {
  final formKey;
  const SignButtonWidget({super.key, required this.formKey});

  @override
  State<SignButtonWidget> createState() => _SignButtonWidgetState();
}

class _SignButtonWidgetState extends State<SignButtonWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 104,
          bottom: 30,
        ),
        child: InkWell(
          onTap: () async {
            if (widget.formKey.currentState == null) {
              provider.changeIsMailCorrect(false);
            }
            if (widget.formKey.currentState!.validate()) {
              provider.changeBoolValue('isLoading');
              if (provider.isSignIn) {
                provider.signIn(context);
              } else {
                bool isRegistered = await provider.isRegistered();
                if (isRegistered) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This user is already registered'),
                    ),
                  );
                } else {
                  provider.sendOTP(email: provider.emailController.text);
                  Navigator.pushNamed(context, NameRoutes.checkCode);
                }
                provider.changeBoolValue('agreeCondition');
                provider.changeBoolValue('isSignIn');
              }
              provider.changeBoolValue('isLoading');
            }
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
                  ? Text(
                      provider.isSignIn ? 'Sign in' : "Sign up",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500),
                    )
                  : const CircularProgressIndicator(
                      color: Color(0xFFFFFFFF),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
