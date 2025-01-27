import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';
import 'package:talky_aplication_2/utils/image_paths.dart';

class ImageAndName extends StatelessWidget {
  const ImageAndName({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Consumer<ChatProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Column(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: provider.receiverUser?.imgUrl ?? '',
                      height: 190,
                      width: 190,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 190,
                          width: 190,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, NameRoutes.chat);
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.primaryBlue,
                          child: Image.asset(
                            ImagePaths.edit,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  provider.receiverUser?.name ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.blackText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  locale.online,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.dividerBlack,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
