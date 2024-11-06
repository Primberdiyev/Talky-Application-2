import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_avatar.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/chat/chat_page/chat_page.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/profile/providers/user_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListUsers extends StatefulWidget {
  final bool isWithOnline;
  const ListUsers({super.key, required this.isWithOnline});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers>  {
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ChatProvider>(
      builder: (context, profileProvider, chatProvider, child) {
        if (profileProvider.usersData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: profileProvider.filteredUsers?.length,
          itemBuilder: (context, index) {
            var user = UserModel.fromJson(
                profileProvider.filteredUsers?[index].data() ?? {});

            String? imgUrl = user.imgUrl;
            bool isOnline = true;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width - 56,
              child: InkWell(
                onTap: () {
                  chatProvider.setReceiverId(
                    name: user.name,
                    imgUrl: imgUrl,
                    newId: user.id,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChatPage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    CustomAvatar(
                      avatarLink: imgUrl,
                      isOnline: isOnline,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: StreamBuilder(
                        stream: chatProvider.getLastMessageWithTime(user.id??''),
                        builder: (context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          String timeAgo = '';
                          String message = 'loading';
                          if (snapshot.connectionState !=
                                  ConnectionState.waiting &&
                              snapshot.hasData &&
                              snapshot.data != null) {
                            String sentTime = snapshot.data!['sentTime'] ?? '';
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
                                    user.name!,
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
  }
}
