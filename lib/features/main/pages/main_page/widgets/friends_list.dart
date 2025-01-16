import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/utils/image_paths.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';
import 'package:timeago/timeago.dart' as timeago;

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _ListUsersState();
}

class _ListUsersState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final chatProvider = context.watch<ChatProvider>();
    final UserDataService userDataService = UserDataService.instance;
    return StreamBuilder<List<UserModel>>(
      stream: userDataService.chattingUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }

        final List<UserModel> chattingUsers = snapshot.data ?? <UserModel>[];

        return ListView.builder(
          itemCount: chattingUsers.length,
          itemBuilder: (context, index) {
            final UserModel user = chattingUsers[index];
            final String imgUrl = user.imgUrl ?? '';
            const bool isOnline = true;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width - 56,
              child: InkWell(
                onTap: () {
                  chatProvider.changeReceiverUser(newUser: user);
                  Navigator.pushNamed(context, NameRoutes.chat);
                },
                child: Row(
                  children: [
                    CustomUserAvatar(
                      avatarLink: imgUrl,
                      isOnline: isOnline,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: StreamBuilder<Map<String, dynamic>>(
                        stream:
                            chatProvider.getLastMessageWithTime(user.id ?? ''),
                        builder: (context, snapshot) {
                          String message = locale.loading;
                          String timeAgo = ImportantTexts.invalidTime;
                          if (snapshot.connectionState !=
                                  ConnectionState.waiting &&
                              snapshot.hasData &&
                              snapshot.data != null) {
                            final String sentTime =
                                snapshot.data?[ImportantTexts.sentTime] ?? '';
                            message = snapshot.data?[ImportantTexts.msg] ?? '';
                            if (sentTime.isNotEmpty) {
                              final sentDateTime = DateTime.parse(sentTime);
                              timeAgo = timeago.format(sentDateTime);
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
                    Image.asset(ImagePaths.chevron),
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
