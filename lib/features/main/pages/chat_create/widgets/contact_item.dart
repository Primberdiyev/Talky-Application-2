import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/main/providers/group_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    required this.model,
    super.key,
    this.toGroup = false,
  });
  final UserModel model;
  final bool toGroup;

  @override
  Widget build(BuildContext context) {
    final isOnline = checkIsOnline(
      model.lastTime ?? DateTime.now().add(const Duration(seconds: -40)),
    );

    return Consumer2<GroupProvider, ChatProvider>(
      builder: (
        context,
        groupProvider,
        chatProvider,
        child,
      ) {
        final isUserPressed = groupProvider.isUserPressed(model.id ?? '');

        return ListTile(
          onTap: () {
            if (!toGroup) {
              chatProvider.changeReceiverUser(model);
              Navigator.pushNamed(context, NameRoutes.chat);
            } else {
              groupProvider.changeUserPressed(model.id!);
            }
          },
          dense: true,
          title: Text(
            model.name ?? 'User',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackText,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          subtitle: Text(model.description ?? (isOnline ? 'at work' : 'offline')),
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
          trailing: toGroup
              ? SvgPicture.asset(
                  isUserPressed ? AppIcons.selected.icon : AppIcons.select.icon,
                )
              : SvgPicture.asset(AppIcons.chevron.icon),
        );
      },
    );
  }

  bool checkIsOnline(DateTime value) {
    final currentTime = DateTime.now();
    return currentTime.difference(value).inSeconds < 30;
  }
}
