import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/features/chat/pages/receiver_user_page.dart/widgets/chat_files_tab.dart';
import 'package:talky_aplication_2/features/chat/pages/receiver_user_page.dart/widgets/image_and_name.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';

class ReceiverUserPage extends StatefulWidget {
  const ReceiverUserPage({super.key});

  @override
  State<ReceiverUserPage> createState() => _ReceiverUserPageState();
}

class _ReceiverUserPageState extends State<ReceiverUserPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (
      context,
      provider,
      child,
    ) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: Center(
          child: provider.receiverUser != null
              ? const Column(
                  children: [
                    ImageAndName(),
                    SizedBox(height: 44),
                    ChatFilesTab(),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      );
    });
  }
}
