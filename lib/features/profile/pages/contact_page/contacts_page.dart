import 'package:flutter/material.dart';
import 'package:talky_aplication_2/features/profile/pages/contact_page/widgets/contact_text.dart';
import 'package:talky_aplication_2/features/profile/pages/contact_page/widgets/contacts_app_bar.dart';
import 'package:talky_aplication_2/features/profile/pages/contact_page/widgets/create_group.dart';
import 'package:talky_aplication_2/features/profile/pages/contact_page/widgets/search_field.dart';
import 'package:talky_aplication_2/features/profile/pages/profile_page/widgets/list_users.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _OnlineUsersPageState();
}

class _OnlineUsersPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: ContactsAppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 28, right: 28, top: 18),
              child: Column(
                children: [
                  SearchField(),
                  CreateGroup(),
                  ContactText(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
                child: ListUsers(
              isWithOnline: true,
            )),
          ],
        ),
      ),
    );
  }
}
