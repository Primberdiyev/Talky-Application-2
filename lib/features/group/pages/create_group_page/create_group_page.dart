import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_text_field.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contact_users.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contact_text.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contacts_app_bar.dart';
import 'package:talky_aplication_2/features/main/providers/group_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
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
    return Consumer<GroupProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        final userDataService = UserDataService.instance;
        return Scaffold(
          appBar: ContactsAppBar(
            centerText: AppTexts.group,
            isDoneActive: true,
            loading: provider.state.isLoading,
            onDone: () async {
              try {
                final groupModel = GroupModel(
                  title: groupNameController.text,
                  usersId: provider.pressedUsers,
                  adminId: userDataService.auth.currentUser?.uid,
                );
                await provider.createGroup(groupModel);
                Future.delayed(Duration.zero, () {
                  Navigator.pushReplacementNamed(
                    context,
                    NameRoutes.group,
                    arguments: groupModel,
                  );
                });
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                  ),
                );
              }
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  CustomTextField(
                    contentPadding: const EdgeInsets.only(
                      top: 11,
                      bottom: 12,
                      left: 11,
                    ),
                    hintText: AppTexts.search,
                    controller: searchControlller,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    hintText: AppTexts.groupName,
                    controller: groupNameController,
                    contentPadding: const EdgeInsets.only(
                      top: 18,
                      bottom: 19,
                      left: 11,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const ContactText(),
                  const SizedBox(height: 10),
                  const ContactUsers(toGroup: true),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
