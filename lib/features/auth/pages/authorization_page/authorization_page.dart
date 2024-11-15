import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/general_sign_button.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/or_widget.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/features/auth/providers/auth_google_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/features/profile/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/app_texts.dart';
import 'package:talky_aplication_2/unilities/image_paths.dart';
import 'package:talky_aplication_2/unilities/profile_state.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthGoogleProvider(),
      child: Consumer<ValueStateProvider>(
          builder: (context, valueProvider, child) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: 115, left: 28, right: 28),
            color: const Color(0xFFF7F7F9),
            child: Column(
              children: [
                const TalkyText(),
                Expanded(child: Consumer<AuthGoogleProvider>(
                    builder: (context, authProvider, child) {
                  if (authProvider.state.isCompleted) {
                    String route = NameRoutes.auth;
                    if (authProvider.profileState == ProfileState.create) {
                      route = NameRoutes.setProfile;
                    } else if (authProvider.profileState ==
                        ProfileState.completed) {
                      route = NameRoutes.main;
                    }
                    Future.delayed(Duration.zero, () {
                      Navigator.pushNamed(context, route);
                    });
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GeneralSignButton(
                        text: valueProvider.isSignIn
                            ? AppTexts.signInText
                            : AppTexts.singUpText,
                        function: () async {
                          final user = await authProvider.signInGoogle();
                          final profileprovider =
                              Provider.of<ProfilePageProvider>(context,
                                  listen: false);
                          await profileprovider.changeCurrentUser(user);
                        },
                        imagePath: ImagePaths.googleImagePath,
                        isLoading: authProvider.state.isLoading,
                      ),
                      const OrWidget(),
                      GeneralSignButton(
                        text: AppTexts.continueMailText,
                        function: () => {
                          Navigator.pushNamed(
                              context, NameRoutes.inputMailPassword)
                        },
                        imagePath: ImagePaths.mainImagePath,
                        isLoading: false,
                      ),
                      const SizedBox(height: 18),
                      const QuestionText(),
                      const SignUpTextButton(),
                      const SizedBox(height: 102),
                    ],
                  );
                }))
              ],
            ),
          ),
        );
      }),
    );
  }
}
