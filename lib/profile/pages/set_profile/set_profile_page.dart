import 'package:flutter/material.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/complete_button.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/image_view.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/input_description.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/input_name.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/profile_text.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/warning_text.dart';
import 'package:talky_aplication_2/auth/pages/input_mail_password_page/widgets/back_button_widget.dart';

class SetProfilePage extends StatelessWidget {
  const SetProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 64, left: 18, right: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButtonWidget(),
                ProfileText(),
              ],
            ),
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
