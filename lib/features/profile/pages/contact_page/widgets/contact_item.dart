import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_avatar.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class ContactItem extends StatelessWidget {
  final UserModel model;

  const ContactItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isOnline = checkIsOnline(model.lastTime ??
        DateTime.now().add(
          const Duration(
            seconds: -1,
          ),
        ));
    return ListTile(
      dense: true,
      title: Text(
        model.name ?? "User",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.blackText,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 2,
      ),
      subtitle: Text(
        model.description ?? (isOnline ? 'at work' : 'offline'),
      ),
      leading: CachedNetworkImage(
        imageUrl: model.imgUrl ?? '',
        imageBuilder: (context, imageProvider) {
          return CustomAvatar(
            avatarLink: model.imgUrl,
            isOnline: isOnline,
          );
        },
        placeholder: (context, url) {
          return SvgPicture.asset(AppIcons.userDefault.icon);
        },
      ),
      trailing: SvgPicture.asset(AppIcons.chevron.icon),
    );
  }

  bool checkIsOnline(DateTime value) {
    return DateTime.now().difference(value).inSeconds < 30;
  }
}
