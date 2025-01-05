import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
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
    final valueProvider =
        Provider.of<ValueStateProvider>(context, listen: false);
    valueProvider.changeBoolValue(BoolValueEnum.agreeCondition);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          function: () {
            Navigator.pop(context);
          },
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 28,
            right: 28,
            top: 26,
          ),
          child: Consumer<ValueStateProvider>(
            builder: (
              context,
              provider,
              child,
            ) {
              return Column(
                children: [
                  const TalkyText(),
                  const SizedBox(
                    height: 40,
                  ),
                  const MailText(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      bottom: 18,
                    ),
                    child: CustomTextField(
                      hintText: locale.enterEmail,
                      controller: emailController,
                      contentPadding: const EdgeInsets.only(
                        top: 18,
                        bottom: 19,
                        left: 20,
                      ),
                    ),
                  ),
                  CustomTextField(
                    hintText: locale.enterPassword,
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
                    height: 74,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SignInAndUpButton(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const QuestionText(),
                        const SignUpTextButton(),
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
