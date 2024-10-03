import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/pages/chat_page/chat_page.dart';
import 'package:talky_aplication_2/profile/providers/chat_provider.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';

class ListUsers extends StatefulWidget {
  final bool isWithOnline;
  const ListUsers({super.key, required this.isWithOnline});
  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfilePageProvider,ChatProvider>(builder: (context, provider,chatProvider, child) {
      if (provider.usersData == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: provider.filteredUsers.length,
        itemBuilder: (context, index) {
          var user = provider.filteredUsers[index];
          String? imgUrl = user['imgUrl'];
          bool isOnline = user['isOnline'];

        

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width - 56,
            child: InkWell(
              onTap: () {
                chatProvider.setReceiverId(user['id']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      name: user['name'],
                      imgUrl: user['imgUrl'],
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  provider.usersData != null && imgUrl != null
                      ? widget.isWithOnline == true
                          ? Stack(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    imgUrl,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isOnline
                                          ? const Color(0xFF2DCA8C)
                                          : const Color(0xFFFF715B),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(imgUrl),
                            )
                      : Image.asset(
                          'assets/images/User.png',
                          width: 30,
                        ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user['name'],
                              style: const TextStyle(
                                color: Color(0xFF243443),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            user['closingTime'] != null
                                ? Text(provider.timeAgo(user['closingTime']))
                                : const Text('Unknown registration time'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                  
                       Text(chatProvider.lastMessage??''),
                    ],
                  ),
                  const Spacer(),
                  Image.asset('assets/images/Chevron.png'),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
