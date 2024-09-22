import 'package:flutter/material.dart';
import 'package:talky_aplication_2/pages/online_users_page/widgets/cancel_and_chat_text.dart';
import 'package:talky_aplication_2/pages/online_users_page/widgets/contact_text.dart';
import 'package:talky_aplication_2/pages/online_users_page/widgets/create_group.dart';
import 'package:talky_aplication_2/pages/online_users_page/widgets/search_field.dart';
import 'package:talky_aplication_2/pages/profile_page/widgets/list_users.dart';

class OnlineUsersPage extends StatelessWidget {
  const OnlineUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  CancelAndChatText(),
                  SearchField(),
                  CreateGroup(),
                  ContactText(),
                ],
              ),
            ),
            Expanded(child: ListUsers()),
          ],
        ),
      ),
    );
  }
}
