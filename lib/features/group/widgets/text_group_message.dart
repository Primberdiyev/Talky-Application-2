import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';

class TextGroupMessage extends StatelessWidget {
  final String imgUrl;
  const TextGroupMessage({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomUserAvatar(
          avatarLink: imgUrl,
        ),
        
      ],
    );
  }
}
