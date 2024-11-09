import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_text_field.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/profile/pages/contact_page/widgets/contact_item.dart';
import 'package:talky_aplication_2/features/profile/pages/contact_page/widgets/contact_text.dart';
import 'package:talky_aplication_2/features/profile/pages/contact_page/widgets/contacts_app_bar.dart';
import 'package:talky_aplication_2/features/profile/pages/contact_page/widgets/create_group.dart';
import 'package:talky_aplication_2/features/profile/providers/user_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _OnlineUsersPageState();
}

class _OnlineUsersPageState extends State<ContactsPage> {
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
                    Consumer<UserProvider>(
                      builder: (context, provider, child) {
                        if (provider.usersData == null) {
                          return CircularProgressIndicator();
                        }
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final model = UserModel.fromJson(
                              provider.usersData?[index].data() ?? {},
                            );

                            return ContactItem(model: model);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              height: 1,
                              color: AppColors.lightBackground,
                            );
                          },
                          itemCount: provider.usersData?.length ?? 1,
                        );
                      },
                    ),
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
