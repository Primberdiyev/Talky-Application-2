import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class ContactItem extends StatelessWidget {
  final UserModel model;

  const ContactItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isOnline = checkIsOnline(
      model.lastTime ??
          DateTime.now().add(
            const Duration(seconds: -40),
          ),
    );
    return Consumer<ChatProvider>(builder: (context, provider, child) {
      return ListTile(
        onTap: () {
          provider.changeReceiverUser(model);
          Navigator.pushNamed(context, NameRoutes.chat);
        },
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
            return CustomUserAvatar(
              avatarLink: model.imgUrl,
              isOnline: isOnline,
              isWithOnline: true,
            );
          },
          placeholder: (context, url) {
            return SvgPicture.asset(AppIcons.userDefault.icon);
          },
        ),
        trailing: SvgPicture.asset(AppIcons.chevron.icon),
      );
    });
  }

  bool checkIsOnline(DateTime value) {
    final currentTime = DateTime.now();
    return currentTime.difference(value).inSeconds < 30;
  }
}
