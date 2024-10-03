import 'package:flutter/material.dart';
import 'package:talky_aplication_2/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/profile/pages/chat_page/widgets/messages_list.dart';
import 'package:talky_aplication_2/profile/pages/chat_page/widgets/send_data.dart';

class ChatPage extends StatelessWidget {
  final String name;
  final String imgUrl;

  const ChatPage({
    super.key,
    required this.name,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: name,
        imgUrl: imgUrl,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MessagesList(),
          SizedBox(height: 44),
          SendData(),
          SizedBox(height: 31),
        ],
      ),
    );
  }
}
