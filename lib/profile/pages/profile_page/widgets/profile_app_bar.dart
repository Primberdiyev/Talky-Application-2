import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfilePageProvider>(context, listen: false);
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          'Chats',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.transparent,
      toolbarHeight: 90,
      centerTitle: true,
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 30, top: 35),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFFF0F0F0),
              backgroundImage: provider.currentUserImgUrl != null
                  ? NetworkImage(provider.currentUserImgUrl!)
                  : const AssetImage('assets/images/User.png'),
            ),
            const Positioned(
              right: 0,
              bottom: 5,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.green,
              ),
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 28, top: 30),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NameRoutes.contacts);
            },
            icon: const Icon(Icons.search),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
