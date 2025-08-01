import 'package:flutter/material.dart';

import 'package:talky_aplication_2/pages/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/pages/authorization_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/pages/authorization_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/pages/check_code_page.dart/widgets/enter_code_text.dart';
import 'package:talky_aplication_2/pages/check_code_page.dart/widgets/input_codes.dart';
import 'package:talky_aplication_2/pages/check_code_page.dart/widgets/sign_up_button.dart';
import 'package:talky_aplication_2/pages/input_mail_password_page/widgets/back_button_widget.dart';

class CheckCodePage extends StatefulWidget {
  const CheckCodePage({super.key});

  @override
  State<CheckCodePage> createState() => _CheckCodePageState();
}

class _CheckCodePageState extends State<CheckCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 26, top: 73),
        color: const Color(0xFFFFFFFF),
        child: Column(
          children: [
            const BackButtonWidget(),
            const Padding(
              padding: EdgeInsets.only(bottom: 40, top: 26),
              child: TalkyText(),
            ),
            const EnterCodeText(),
            const SizedBox(
              height: 50,
            ),
            const InputCodes(),
            SignUpButton(),
            const QuestionText(),
            const SignUpTextButton(),
          ],
        ),
      ),
    );
  }
}
