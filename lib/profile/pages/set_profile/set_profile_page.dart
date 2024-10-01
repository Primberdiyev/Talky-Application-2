import 'package:flutter/material.dart';
import 'package:talky_aplication_2/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/complete_button.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/image_view.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/input_description.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/input_name.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/warning_text.dart';

class SetProfilePage extends StatelessWidget {
  const SetProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar('Profile'),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only( left: 18, right: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageView(),
            InputName(),
            InputDescription(),
            WarningText(),
            CompleteButton(),
          ],
        ),
      ),
    );
  }
}
