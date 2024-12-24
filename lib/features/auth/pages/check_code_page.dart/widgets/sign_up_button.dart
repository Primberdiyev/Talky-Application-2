import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return ChangeNotifierProvider(
      create: (context) => SignInAndUpProvider(),
      child: Consumer2<ValueStateProvider, SignInAndUpProvider>(
        builder: (
          context,
          valueProvider,
          signInAndUpProvider,
          child,
        ) {
          final isLoading = signInAndUpProvider.state == Statuses.loading;

          if (signInAndUpProvider.state.isCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, NameRoutes.account);
              }
            });
          }

          return Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            child: InkWell(
              onTap: () {
                signInAndUpProvider.signUp();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 56,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF377DFF),
                ),
                child: Center(
                  child: !isLoading
                      ? Text(
                          locale.signUp,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
