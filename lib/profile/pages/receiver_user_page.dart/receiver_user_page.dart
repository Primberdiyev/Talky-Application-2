import 'package:flutter/material.dart';

import 'package:talky_aplication_2/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/profile/pages/receiver_user_page.dart/widgets/chat_files_tab.dart';
import 'package:talky_aplication_2/profile/pages/receiver_user_page.dart/widgets/image_and_name.dart';

class ReceiverUserPage extends StatelessWidget {
  const ReceiverUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            ImageAndName(),
            SizedBox(height: 44),
            ChatFilesTab(),
          ],
        ),
      ),
    );
  }
}
