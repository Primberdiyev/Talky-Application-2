import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/providers/otp_provider.dart';
import 'package:talky_aplication_2/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/unilities/bool_value_enum.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class SignButtonWidget extends StatefulWidget {
  const SignButtonWidget({super.key});

  @override
  State<SignButtonWidget> createState() => _SignButtonWidgetState();
}

class _SignButtonWidgetState extends State<SignButtonWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueStateProvider, SignInAndUpProvider>(
        builder: (context, valueProvider, signprovider, child) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 104,
          bottom: 30,
        ),
        child: InkWell(
          onTap: () async {
            valueProvider.changeBoolValue(BoolValueEnum.isLoading);
            if (valueProvider.isSignIn) {
              signprovider.signIn(context);
            } else {
              bool isRegistered = await signprovider.isRegistered();
              if (isRegistered) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This user is already registered'),
                  ),
                );
              } else {
                final otpProvider =
                    Provider.of<OtpProvider>(context, listen: false);
                otpProvider.sendOTP(email: signprovider.emailController.text);
                Navigator.pushNamed(context, NameRoutes.checkCode);
              }
              valueProvider.changeBoolValue(BoolValueEnum.agreeCondition);
              valueProvider.changeBoolValue(BoolValueEnum.isSignIn);
            }
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
                  ? Text(
                      valueProvider.isSignIn ? 'Sign in' : "Sign up",
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
