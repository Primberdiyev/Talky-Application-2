import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';

class InputCodes extends StatelessWidget {
  const InputCodes({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
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
        onChanged: (value) {},
        onSubmitted: (pin) async {
          try {
            await provider.signUp(context, provider.email, provider.password);

            Navigator.pushNamed(context, '/AccountPage');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
      );
    });
  }
}
