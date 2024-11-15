import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/chat/chat_page/chat_page.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/profile/providers/user_provider.dart';
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
      builder: (context, userProvider, chatProvider, child) {
        return StreamBuilder(
            stream: userProvider.getChattingUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data == null) {
                return Text('');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                SizedBox.shrink();
              }

              List<UserModel> chattingUsers = snapshot.data!.toList();
              return ListView.builder(
                itemCount: chattingUsers.length,
                itemBuilder: (context, index) {
                  var user = chattingUsers[index];

                  String? imgUrl = user.imgUrl;
                  bool isOnline = true;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                              builder: (context,
                                  AsyncSnapshot<Map<String, dynamic>>
                                      snapshot) {
                                String timeAgo = '';
                                String message = 'loading';
                                if (snapshot.connectionState !=
                                        ConnectionState.waiting &&
                                    snapshot.hasData &&
                                    snapshot.data != null) {
                                  String sentTime =
                                      snapshot.data!['sentTime'] ?? '';
                                  message = snapshot.data!['msg'] ?? '';
                                  if (sentTime.isNotEmpty) {
                                    try {
                                      final DateTime sentDateTime =
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
            });
      },
    );
  }
}
