import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.userModel,
    this.groupModel,
  });
  final UserModel? userModel;
  final GroupModel? groupModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomUserAvatar(
              avatarLink: userModel != null ? userModel?.imgUrl : groupModel?.imgUrl, //value.userModel?.imgUrl,
              isOnline: true,
              isWithOnline: userModel != null,
            ),
            Text(
              userModel != null ? 'Chats' : groupModel?.title ?? 'Group',
              style: const TextStyle(
                color: AppColors.blackText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons.search.icon,
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
