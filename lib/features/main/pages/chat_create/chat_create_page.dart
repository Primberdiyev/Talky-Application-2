import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_text_field.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contact_users.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contact_text.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contacts_app_bar.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/create_group.dart';
import 'package:talky_aplication_2/features/main/providers/all_users_provider.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class ChatCreatePage extends StatefulWidget {
  const ChatCreatePage({super.key});

  @override
  State<ChatCreatePage> createState() => _OnlineUsersPageState();
}

class _OnlineUsersPageState extends State<ChatCreatePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<AllUsersProvider>().getAllUsers();
      },
    );
    super.initState();
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ContactsAppBar(
          centerText: 'Chat',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Consumer<AllUsersProvider>(
                      builder: (
                        context,
                        provider,
                        child,
                      ) {
                        return CustomTextField(
                          hintText: 'Search',
                          controller: controller,
                          suffixIcon: SvgPicture.asset(AppIcons.search.icon),
                          onChanged: (value) => provider.onSearchChanged(value),
                        );
                      },
                    ),
                    const CreateGroup(),
                    const ContactText(),
                    const SizedBox(height: 20),
                    const ContactUsers(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
