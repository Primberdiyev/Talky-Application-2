import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/widgets/contact_item.dart';
import 'package:talky_aplication_2/features/profile/providers/all_users_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class ConcactUsers extends StatelessWidget {
  final bool toGroup;
  const ConcactUsers({super.key, this.toGroup = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<AllUsersProvider>(
      builder: (context, provider, child) {
        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final UserModel model = provider.allUsers[index];

            return ContactItem(
              model: model,
              toGroup: toGroup,
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1,
              height: 1,
              color: AppColors.lightBackground,
            );
          },
          itemCount: provider.allUsers.length,
        );
      },
    );
  }
}
