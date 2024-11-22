import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class ImageAndName extends StatelessWidget {
  const ImageAndName({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'online',
                  style: TextStyle(fontSize: 14, color: AppColors.dividerBlack),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
