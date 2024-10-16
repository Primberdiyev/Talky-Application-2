import 'package:flutter/material.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContactsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leadingWidth: 83,
      leading: Padding(
        padding: const EdgeInsets.only(top: 23, left: 28),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: const Padding(
        padding: EdgeInsets.only(top: 23),
        child: Text(
          'Chat',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
