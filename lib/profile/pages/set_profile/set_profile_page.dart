import 'package:flutter/material.dart';
import 'package:talky_aplication_2/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/complete_button.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/image_view.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/input_description.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/input_name.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({super.key});

  @override
  State<SetProfilePage> createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Profile'),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImageView(),
            InputName(controller: nameController),
            InputDescription(controller: descriptionController),
            CompleteButton(
              nameController: nameController,
              descriptionController: descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}
