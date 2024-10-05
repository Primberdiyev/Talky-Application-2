import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/providers/chat_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class ImageAndName extends StatelessWidget {
  const ImageAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 95,
                backgroundImage: provider.reveiverImgUrl != null
                    ? NetworkImage(provider.reveiverImgUrl!)
                    : const AssetImage('assets/images/User.png'),
              ),
              const SizedBox(height: 20),
              Text(
                provider.reveiverName!,
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
          )
        ],
      );
    });
  }
}
