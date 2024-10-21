import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/pages/authorization_page/widgets/general_sign_button.dart';
import 'package:talky_aplication_2/auth/pages/authorization_page/widgets/or_widget.dart';
import 'package:talky_aplication_2/auth/pages/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/auth/pages/authorization_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/auth/pages/authorization_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/auth/providers/auth_google_provider.dart';
import 'package:talky_aplication_2/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/app_texts.dart';
import 'package:talky_aplication_2/unilities/image_paths.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueStateProvider, AuthGoogleProvider>(
        builder: (context, valueProvider, authProvider, child) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 115, left: 28, right: 28),
          color: const Color(0xFFF7F7F9),
          child: Column(
            children: [
              const TalkyText(),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GeneralSignButton(
                    text: valueProvider.isSignIn
                        ? AppTexts.signInText
                        : AppTexts.singUpText,
                    function: () {
                      authProvider.signInWithGoogle(context);
                    },
                    imagePath: ImagePaths.googleImagePath,
                    isLoading: authProvider.state.isLoading,
                  ),
                  const OrWidget(),
                  GeneralSignButton(
                    text: AppTexts.continueMailText,
                    function: () => {
                      Navigator.pushNamed(context, NameRoutes.inputMailPassword)
                    },
                    imagePath: ImagePaths.mainImagePath,
                    isLoading: false,
                  ),
                  const SizedBox(height: 18),
                  const QuestionText(),
                  const SignUpTextButton(),
                  const SizedBox(height: 102),
                ],
              ))
            ],
          ),
        ),
      );
    });
  }
}
