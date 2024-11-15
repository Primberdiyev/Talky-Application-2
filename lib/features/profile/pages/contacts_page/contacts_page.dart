import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_text_field.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/widgets/concact_user.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/widgets/contact_text.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/widgets/contacts_app_bar.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/widgets/create_group.dart';
import 'package:talky_aplication_2/features/profile/providers/all_users_provider.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _OnlineUsersPageState();
}

class _OnlineUsersPageState extends State<ContactsPage> {
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
        appBar: ContactsAppBar(
          centerText: 'Chat',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CustomTextField(
                      hintText: 'Search',
                      controller: controller,
                      suffixIcon: SvgPicture.asset(AppIcons.search.icon),
                    ),
                    CreateGroup(),
                    ContactText(),
                    SizedBox(height: 20),
                    ConcactUsers(),
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
