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
  });

  @override
  State<CheckCodePage> createState() => _CheckCodePageState();
}

class _CheckCodePageState extends State<CheckCodePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignInAndUpProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return const Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(),
          body: Padding(
            padding: EdgeInsets.only(
              left: 26,
            ),
            child: Column(
              children: [
                TalkyText(),
                EnterCodeText(),
                SizedBox(height: 50),
                InputCodes(),
                SignUpButton(),
                QuestionText(),
                SignUpTextButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
