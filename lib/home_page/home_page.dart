import 'package:flutter/material.dart';
import 'package:talky_aplication_2/home_page/widgets/mail_button.dart';
import 'package:talky_aplication_2/home_page/widgets/or_widget.dart';
import 'package:talky_aplication_2/home_page/widgets/question_text.dart';
import 'package:talky_aplication_2/home_page/widgets/sign_in_button.dart';
import 'package:talky_aplication_2/home_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/home_page/widgets/talky_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 115, left: 28, right: 28),
        color: const Color(0xFFF7F7F9),
        child: const Column(
          children: [
            TalkyText(),
            SignInButton(),
            OrWidget(),
            MailButton(),
            QuestionText(),
            SignUpTextButton(),
          ],
        ),
      ),
    );
  }
}
