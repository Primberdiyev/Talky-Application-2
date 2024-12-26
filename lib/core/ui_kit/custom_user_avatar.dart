import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/features/group/widgets/default_user.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';

class CustomUserAvatar extends StatelessWidget {
  const CustomUserAvatar({
    super.key,
    this.avatarLink,
    this.isOnline = false,
    this.isWithOnline = false,
  });
  final String? avatarLink;
  final bool isOnline;
  final bool isWithOnline;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (avatarLink?.isNotEmpty == true)
          CachedNetworkImage(
            imageUrl: avatarLink ?? '',
            height: 50,
            width: 50,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            errorWidget: (
              context,
              url,
              error,
            ) =>
                const DefaultUser(),
            placeholder: (context, url) => const DefaultUser(),
          )
        else
          const DefaultUser(),
        if (isWithOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOnline ? AppColors.onlineColor : AppColors.offline,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
