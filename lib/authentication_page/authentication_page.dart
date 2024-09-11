import 'package:flutter/material.dart';
import 'package:talky_aplication_2/authentication_page/widgets/back_button_widget.dart';
import 'package:talky_aplication_2/authentication_page/widgets/condition_widget.dart';
import 'package:talky_aplication_2/authentication_page/widgets/forgot_password_text.dart';
import 'package:talky_aplication_2/authentication_page/widgets/input_mail.dart';
import 'package:talky_aplication_2/authentication_page/widgets/input_password.dart';
import 'package:talky_aplication_2/authentication_page/widgets/mail_text.dart';
import 'package:talky_aplication_2/authentication_page/widgets/sign_button_widget.dart';
import 'package:talky_aplication_2/authentication_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/home_page/widgets/question_text.dart';
import 'package:talky_aplication_2/home_page/widgets/sign_up_text_button.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  // void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 70, left: 28, right: 28),
        color: const Color(0xFFFFFFFF),
        child: const Column(
          children: [
            BackButtonWidget(),
            TalkyText(),
            MailText(),
            InputMail(),
            InputPassword(), 
            ForgotPasswordText(),
            ConditionWidget(),
            SignButtonWidget(),
            QuestionText(),
            SignUpTextButton(),
          ],
        ),
      ),
    );
  }
}
