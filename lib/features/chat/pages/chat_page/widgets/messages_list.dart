import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/audio_message.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/file_message.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/image_message.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/text_messages.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/routes/message_types.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (
        context,
        value,
        child,
      ) {
        return Flexible(
          child: Consumer<ChatProvider>(
            builder: (
              context,
              provider,
              child,
            ) {
              return StreamBuilder(
                stream:
                    provider.getAllMessages(provider.receiverUser?.id ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    final messages = snapshot.data?.docs;

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages?.length,
                      itemBuilder: (context, index) {
                        final message =
                            messages?[messages.length - 1 - index].data();
                        final isMine =
                            provider.currentUser?.uid == message?['fromId'];
                        switch (message?['type']) {
                          case MessageTypes.text:
                            return TextMessages(
                              isMine: isMine,
                              message: message?['msg'],
                            );
                          case MessageTypes.image:
                            return ImageMessage(
                              isMine: isMine,
                              link: message?['msg'],
                            );
                          case MessageTypes.file:
                            return FileMessage(
                              isMine: isMine,
                              link: message?['msg'],
                            );
                          case MessageTypes.audio:
                            final String url = message?['msg'];
                            return AudioMessage(isMine: isMine, link: url);
                        }
                        return null;
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        ImportantTexts.noMessages,
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
      },
    );
  }
}
