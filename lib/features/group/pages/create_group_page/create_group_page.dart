import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_text_field.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contact_users.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contact_text.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contacts_app_bar.dart';
import 'package:talky_aplication_2/features/main/providers/group_provider.dart';
import 'package:talky_aplication_2/features/main/providers/user_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:uuid/uuid.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDataService = UserDataService.instance;
    final locale = context.locale;
    final currentUserId = userDataService.auth.currentUser?.uid;
    return Consumer2<GroupProvider, UserProvider>(
      builder: (
        context,
        provider,
        userProvider,
        child,
      ) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: ContactsAppBar(
            centerText: locale.group,
            isDoneActive: true,
            loading: provider.state.isLoading,
            onDone: () {
              final id = const Uuid().v4();
              final groupModel = GroupModel(
                title: groupNameController.text,
                usersId: provider.pressedUsers,
                adminId: currentUserId,
                id: id,
                imgUrl: null,
              );
              provider
                  .createGroup(
                model: groupModel,
                adminId: currentUserId ?? '',
              )
                  .then((_) {
                if (context.mounted && provider.groupModel != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    NameRoutes.group,
                    arguments: provider.groupModel,
                  );
                }
              });
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
                    hintText: locale.search,
                    controller: searchController,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    hintText: locale.groupName,
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
