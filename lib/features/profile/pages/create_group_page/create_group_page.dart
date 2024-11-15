import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_text_field.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/widgets/concact_user.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/widgets/contact_text.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/widgets/contacts_app_bar.dart';
import 'package:talky_aplication_2/unilities/app_texts.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController searchControlller = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchControlller.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactsAppBar(
        centerText: AppTexts.group,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              CustomTextField(
                contentPadding: EdgeInsets.only(top: 11, bottom: 12, left: 11),
                hintText: AppTexts.search,
                controller: searchControlller,
              ),
              SizedBox(height: 18),
              CustomTextField(
                hintText: AppTexts.groupName,
                controller: groupNameController,
                contentPadding: EdgeInsets.only(top: 18, bottom: 19, left: 11),
              ),
              SizedBox(height: 18),
              ContactText(),
              SizedBox(height: 10),
              ConcactUsers(toGroup: true),
            ],
          ),
        ),
      ),
    );
  }
}
