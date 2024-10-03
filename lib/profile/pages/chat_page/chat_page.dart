import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/profile/providers/chat_provider.dart';
import 'package:talky_aplication_2/profile/pages/chat_page/widgets/send_message.dart';

class ChatPage extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String receiverId;

  const ChatPage({
    super.key,
    required this.name,
    required this.imgUrl,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: name,
        imgUrl: imgUrl,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, provider, _) {
                  return StreamBuilder(
                    stream: provider.getAllMessages(receiverId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData) {
                        final messages = snapshot.data!.docs;

                        return ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index].data();
                            final isMine =
                                provider.user.uid == message['fromId'];

                            return ListTile(
                              title: Align(
                                alignment: isMine
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isMine
                                        ? Colors.blueAccent
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    message['msg'],
                                    style: TextStyle(
                                      color: isMine
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No messages yet'),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            SendMessage(receiverId: receiverId),
            const SizedBox(
              height: 31,
            ),
          ],
        ),
      ),
    );
  }
}
