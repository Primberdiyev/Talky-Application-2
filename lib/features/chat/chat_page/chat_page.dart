import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/features/chat/chat_page/widgets/action_button.dart';
import 'package:talky_aplication_2/features/chat/chat_page/widgets/messages_list.dart';
import 'package:talky_aplication_2/features/chat/chat_page/widgets/send_data.dart';
import 'package:talky_aplication_2/features/chat/providers/audio_provider.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: CustomAppBar(
          text: provider.receiverName,
          imgUrl: provider.receiverImgUrl,
          function: () {
            Navigator.pushNamed(context, NameRoutes.receiverUser);
          },
        ),
        body: ChangeNotifierProvider(
          create: (context) => AudioProvider(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MessagesList(),
              SizedBox(height: 31),
              SendData(),
              SizedBox(height: 31),
            ],
          ),
        ),
        floatingActionButton: const ActionButton(),
      );
    });
  }
}
