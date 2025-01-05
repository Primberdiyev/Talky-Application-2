import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/question_text.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/sign_up_text_button.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/widgets/talky_text.dart';
import 'package:talky_aplication_2/features/auth/pages/check_code_page.dart/widgets/enter_code_text.dart';
import 'package:talky_aplication_2/features/auth/pages/check_code_page.dart/widgets/input_codes.dart';
import 'package:talky_aplication_2/features/auth/pages/check_code_page.dart/widgets/sign_up_button.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';

class CheckCodePage extends StatefulWidget {
  const CheckCodePage({
    super.key,
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  State<CheckCodePage> createState() => _CheckCodePageState();
}

class _CheckCodePageState extends State<CheckCodePage> {
  final TextEditingController inputCodeController = TextEditingController();
  @override
  void dispose() {
    inputCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInAndUpProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 26,
            ),
            child: Column(
              children: [
                const TalkyText(),
                const EnterCodeText(),
                const SizedBox(height: 50),
                InputCodes(
                  controller: inputCodeController,
                ),
                const Spacer(),
                SignUpButton(
                  inputCodeController: inputCodeController,
                  email: widget.email,
                  password: widget.password,
                ),
                const QuestionText(),
                const SignUpTextButton(),
                const SizedBox(
                  height: 102,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
