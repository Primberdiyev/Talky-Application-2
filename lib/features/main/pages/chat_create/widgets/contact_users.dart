import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/widgets/contact_item.dart';
import 'package:talky_aplication_2/features/main/providers/all_users_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class ContactUsers extends StatelessWidget {
  const ContactUsers({super.key, this.toGroup = false});
  final bool toGroup;

  @override
  Widget build(BuildContext context) {
    return Consumer<AllUsersProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        if (provider.filteredUsers.isEmpty) {
          return const SizedBox.shrink();
        }
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final model = provider.filteredUsers[index];

            return ContactItem(
              model: model,
              toGroup: toGroup,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
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
