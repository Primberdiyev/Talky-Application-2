import 'package:flutter/material.dart';
import 'package:talky_aplication_2/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/profile/pages/chat_page/widgets/send_message.dart';

class ChatPage extends StatelessWidget {
  final String name;
  final String imgUrl;
  const ChatPage({super.key, required this.name, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: name,
        imgUrl: imgUrl,
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 28, right: 28, bottom: 31),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SendMessage(),
          ],
        ),
      ),
    );
  }
}
