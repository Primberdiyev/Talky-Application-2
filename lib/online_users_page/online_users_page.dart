import 'package:flutter/material.dart';
import 'package:talky_aplication_2/online_users_page/widgets/cancel_and_chat_text.dart';
import 'package:talky_aplication_2/online_users_page/widgets/create_group.dart';
import 'package:talky_aplication_2/online_users_page/widgets/search_field.dart';

class OnlineUsersPage extends StatelessWidget {
  const OnlineUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 28, right: 28, top: 23),
        child: Column(
          children: [
            CancelAndChatText(),
            SearchField(),
            CreateGroup(),
          ],
        ),
      ),
    );
  }
}
