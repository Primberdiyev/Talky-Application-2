import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Consumer<ValueStateProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 44,
              top: 18,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, NameRoutes.forgotPassword);
                  },
                  child: Text(
                    locale.forgotPassword,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF243443),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Visibility(
                  visible: !provider.isEmailCorrect,
                  child:  Text(
                    locale.inCorrect,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
