import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/providers/chat_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, value, child) {
      return Expanded(
        child: Consumer<ChatProvider>(
          builder: (context, provider, _) {
            return StreamBuilder(
              stream: provider.getAllMessages(provider.reveiverId),
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

                      return message['type'] == 'text'
                          ? ListTile(
                              title: Align(
                                alignment: isMine
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  padding: const EdgeInsets.all(10),
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.5),
                                  decoration: BoxDecoration(
                                    color: isMine
                                        ? AppColors.primaryBlue
                                        : AppColors.chatColor,
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
                            )
                          : message['type'] == 'image'
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      right: 28, left: 28),
                                  alignment: isMine
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      message['msg'],
                                      width: 125,
                                      height: 125,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : message['type'] == 'pdf'
                                  ? ListTile(
                                      title: Align(
                                        alignment: isMine
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: isMine
                                                ? AppColors.primaryBlue
                                                : AppColors.chatColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'PDF faylini ko\'rish',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListTile(
                                      title: Align(
                                      alignment: isMine
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: isMine
                                                ? AppColors.primaryBlue
                                                : AppColors.chatColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'Audio faylini tinglash',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ));
                    },
                  );
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
