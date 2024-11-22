import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/chat_page.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/main/providers/user_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class FriendsList extends StatefulWidget {
  const FriendsList({
    super.key,
  });

  @override
  State<FriendsList> createState() => _ListUsersState();
}

class _ListUsersState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ChatProvider>(
      builder: (
        context,
        userProvider,
        chatProvider,
        child,
      ) {
        return StreamBuilder(
          stream: userProvider.getChattingUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null ||
                (!snapshot.hasData || snapshot.data!.isEmpty)) {
              const SizedBox.shrink();
            }

            final chattingUsers = snapshot.data?.toList() ?? [];
            if (chattingUsers.isEmpty) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
              itemCount: userProvider.chattingUsers?.length,
              itemBuilder: (context, index) {
                final user = chattingUsers[index];
                final imgUrl = user.imgUrl;
                const isOnline = true;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width - 56,
                  child: InkWell(
                    onTap: () {
                      chatProvider.changeReceiverUser(user);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        CustomUserAvatar(
                          avatarLink: imgUrl,
                          isOnline: isOnline,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: StreamBuilder(
                            stream: chatProvider
                                .getLastMessageWithTime(user.id ?? ''),
                            builder: (
                              context,
                              AsyncSnapshot<Map<String, dynamic>> snapshot,
                            ) {
                              var timeAgo = '';
                              var message = 'loading';
                              if (snapshot.connectionState !=
                                      ConnectionState.waiting &&
                                  snapshot.hasData &&
                                  snapshot.data != null) {
                                final String sentTime =
                                    snapshot.data!['sentTime'] ?? '';
                                message = snapshot.data!['msg'] ?? '';
                                if (sentTime.isNotEmpty) {
                                  try {
                                    final sentDateTime =
                                        DateTime.parse(sentTime);
                                    timeAgo = timeago.format(sentDateTime);
                                  } catch (e) {
                                    timeAgo = '';
                                  }
                                }
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user.name ?? '',
                                        style: const TextStyle(
                                          color: Color(0xFF243443),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        timeAgo,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    message.length <= 30
                                        ? message
                                        : '${message.substring(0, 30)}...',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Image.asset('assets/images/Chevron.png'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
