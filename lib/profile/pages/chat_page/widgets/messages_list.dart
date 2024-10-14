import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/pages/chat_page/widgets/get_name_from_url.dart';
import 'package:talky_aplication_2/profile/providers/chat_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    void openPDF(File file) =>
        Navigator.pushNamed(context, NameRoutes.pdfViewer, arguments: file);

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
                        switch (message['type']) {
                          case "text":
                            return ListTile(
                              title: Align(
                                alignment: isMine
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 10),
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
                            );
                          case 'image':
                            return Container(
                              margin: const EdgeInsets.only(
                                  right: 28, left: 28, bottom: 15),
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
                            );
                          case "file":
                            return ListTile(
                              title: Align(
                                alignment: isMine
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  height: 80,
                                  width: 240,
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 15),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isMine
                                        ? AppColors.primaryBlue
                                        : AppColors.chatColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 80,
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: InkWell(
                                            onTap: () async {
                                              final file = await provider
                                                  .loadFile(message['msg']);
                                              if (file != null) {
                                                openPDF(file);
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            maxLines: 2,
                                            GetNameFromUrl().getFileNameFromUrl(
                                              message['msg'],
                                            ),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          case "audio":
                            return ListTile(
                                title: Align(
                              alignment: isMine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isMine
                                        ? AppColors.primaryBlue
                                        : AppColors.chatColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Audio faylini tinglash',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ));
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
