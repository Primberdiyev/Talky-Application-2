import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/chat_page/widgets/audio_message.dart';
import 'package:talky_aplication_2/features/chat/chat_page/widgets/file_message.dart';
import 'package:talky_aplication_2/features/chat/chat_page/widgets/image_message.dart';
import 'package:talky_aplication_2/features/chat/chat_page/widgets/text_messages.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, value, child) {
      return Expanded(
        child: Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return StreamBuilder(
              stream: provider.getAllMessages(provider.receiverUser?.id ?? ''),
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
                        final message =
                            messages[messages.length - 1 - index].data();
                        final isMine = provider.user.uid == message['fromId'];
                        switch (message['type']) {
                          case "text":
                            return TextMessages(
                              isMine: isMine,
                              message: message['msg'],
                            );
                          case 'image':
                            return ImageMessage(
                                isMine: isMine, link: message['msg']);
                          case "file":
                            return FileMessage(
                                isMine: isMine, link: message['msg']);
                          case 'audio':
                            String url = message['msg'];
                            return AudioMessage(isMine: isMine, link: url);
                        }
                        return null;
                      });
                } else {
                  return const Center(
                    child: Text(
                      'No messages yet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      );
    });
  }
}
