import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_text_field.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/condition_widget.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/forgot_password_text.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/mail_text.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/sign_in_and_up_button.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/utils/app_texts.dart';
import 'package:talky_aplication_2/utils/bool_value_enum.dart';

class InputMailPasswordPage extends StatefulWidget {
  const InputMailPasswordPage({super.key});

  @override
  State<InputMailPasswordPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<InputMailPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          function: () {
            Navigator.pop(context);
          },
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Consumer<ValueStateProvider>(
            builder: (
              context,
              provider,
              child,
            ) {
              return Column(
                children: [
                  const TalkyText(),
                  const MailText(),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    hintText: AppTexts.enterEmail,
                    controller: emailController,
                    contentPadding: const EdgeInsets.only(
                      top: 18,
                      bottom: 19,
                      left: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                    hintText: AppTexts.enterPassword,
                    controller: passwordController,
                    suffixTab: () => provider.changeBoolValue(
                      BoolValueEnum.isHideText,
                    ),
                    suffixIcon: Icon(
                      size: 24,
                      provider.isHideText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    contentPadding: const EdgeInsets.only(
                      top: 18,
                      bottom: 19,
                      left: 20,
                    ),
                  ),
                  const ForgotPasswordText(),
                  const ConditionWidget(),
                  const SizedBox(
                    height: 104,
                  ),
                  SignInAndUpButton(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const QuestionText(),
                  const SignUpTextButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
