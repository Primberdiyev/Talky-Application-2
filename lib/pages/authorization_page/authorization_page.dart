import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/pages/authorization_page/widgets/general_sign_button.dart';
import 'package:talky_aplication_2/pages/authorization_page/widgets/or_widget.dart';
import 'package:talky_aplication_2/pages/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/pages/authorization_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/pages/authorization_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/services/auth_service.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';
import 'package:talky_aplication_2/unilities/app_texts.dart';
import 'package:talky_aplication_2/unilities/images_path.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, chil) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 115, left: 28, right: 28),
          color: AppColors.fontColor,
          child: Column(
            children: [
              const TalkyText(),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GeneralSignButton(
                    text: AppTexts.signInText,
                    function: () => AuthService().signInWithGoogle(context),
                    imagePath: ImagesPath.googleImage,
                    isLoading: !provider.isLoading,
                  ),
                  const OrWidget(),
                  GeneralSignButton(
                      text: AppTexts.continueMail,
                      function: () {
                        Navigator.pushNamed(
                            context, NameRoutes.inputMailPassword);
                      },
                      imagePath: ImagesPath.mainImage,
                      isLoading: !provider.isLoading),
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
