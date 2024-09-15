import 'package:flutter/material.dart';
import 'package:talky_aplication_2/input_mail_password_page/widgets/back_button_widget.dart';
import 'package:talky_aplication_2/input_mail_password_page/widgets/condition_widget.dart';
import 'package:talky_aplication_2/input_mail_password_page/widgets/forgot_password_text.dart';
import 'package:talky_aplication_2/input_mail_password_page/widgets/input_mail.dart';
import 'package:talky_aplication_2/input_mail_password_page/widgets/input_password.dart';
import 'package:talky_aplication_2/input_mail_password_page/widgets/mail_text.dart';
import 'package:talky_aplication_2/input_mail_password_page/widgets/sign_button_widget.dart';
import 'package:talky_aplication_2/input_mail_password_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/authorization_page/widgets/sign_up_text_button.dart';

class InputMailPasswordPage extends StatefulWidget {
  const InputMailPasswordPage({super.key});

  @override
  State<InputMailPasswordPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<InputMailPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 70, left: 28, right: 28),
        color: const Color(0xFFFFFFFF),
        child: Column(
          children: [
            const BackButtonWidget(),
            const TalkyText(),
            const MailText(),
            InputMail(formKey: formKey),
            const InputPassword(),
            const ForgotPasswordText(),
            const ConditionWidget(),
            SignButtonWidget(formKey: formKey),
            const QuestionText(),
            const SignUpTextButton(),
          ],
        ),
      ),
    );
  }
}
