import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/condition_widget.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/forgot_password_text.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/input_mail.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/input_password.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/mail_text.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/sign_button_widget.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';

class InputMailPasswordPage extends StatefulWidget {
  const InputMailPasswordPage({super.key});

  @override
  State<InputMailPasswordPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<InputMailPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SignInAndUpProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: CustomAppBar(
              function: () {
                Navigator.pop(context);
              },
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: Column(
                children: [
                  const TalkyText(),
                  const MailText(),
                  const InputMail(),
                  const InputPassword(),
                  const ForgotPasswordText(),
                  const ConditionWidget(),
                  SignButtonWidget(
                    isLoading: provider.state.isLoading,
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
