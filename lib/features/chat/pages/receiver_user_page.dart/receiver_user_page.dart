import 'package:flutter/material.dart';

import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/features/chat/pages/receiver_user_page.dart/widgets/chat_files_tab.dart';
import 'package:talky_aplication_2/features/chat/pages/receiver_user_page.dart/widgets/image_and_name.dart';

class ReceiverUserPage extends StatelessWidget {
  const ReceiverUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
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
