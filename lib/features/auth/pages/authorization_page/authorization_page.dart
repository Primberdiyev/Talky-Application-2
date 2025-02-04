import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_auth_button.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/or_widget.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/features/auth/providers/auth_google_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';
import 'package:talky_aplication_2/utils/app_icons.dart';
import 'package:talky_aplication_2/utils/profile_state.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return ChangeNotifierProvider(
      create: (context) => AuthGoogleProvider(),
      child: Consumer<ValueStateProvider>(
        builder: (
          context,
          valueProvider,
          child,
        ) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                top: 115,
                left: 28,
                right: 28,
                bottom: 102,
              ),
              child: Column(
                children: [
                  const TalkyText(),
                  const Spacer(),
                  Consumer<AuthGoogleProvider>(
                    builder: (
                      context,
                      authProvider,
                      child,
                    ) {
                      var route = NameRoutes.auth;
                      final condition = authProvider.state.isCompleted;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (context.mounted && condition) {
                          if (authProvider.profileState ==
                              ProfileState.create) {
                            route = NameRoutes.setProfile;
                          } else if (authProvider.profileState ==
                              ProfileState.completed) {
                            route = NameRoutes.main;
                          }

                          if (mounted) {
                            Navigator.pushNamed(context, route);
                          }
                        }
                      });
                      return CustomAuthButton(
                        textFontSize: 16,
                        textColor: AppColors.blackText,
                        buttonColor: Colors.white,
                        iconPath: AppIcons.google.icon,
                        text: valueProvider.isSignIn
                            ? locale.signInText
                            : locale.singUpText,
                        function: () {
                          authProvider.signInGoogle();
                        },
                        isLoading: authProvider.state.isLoading,
                      );
                    },
                  ),
                  const OrWidget(),
                  CustomAuthButton(
                    textFontSize: 16,
                    textColor: AppColors.blackText,
                    buttonColor: Colors.white,
                    iconPath: AppIcons.mail.icon,
                    text: locale.continueMailText,
                    function: () => {
                      Navigator.pushNamed(
                        context,
                        NameRoutes.inputMailPassword,
                      ),
                    },
                    isLoading: false,
                  ),
                  const SizedBox(
                    height: 56,
                  ),
                  const QuestionText(),
                  const SignUpTextButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
