import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';

class InputCodes extends StatelessWidget {
  const InputCodes({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInAndUpProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Pinput(
          controller: provider.inputCodeController,
          defaultPinTheme: PinTheme(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFAAB0B7),
              ),
            ),
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            width: 60,
            height: 60,
          ),
        );
      },
    );
  }
}
