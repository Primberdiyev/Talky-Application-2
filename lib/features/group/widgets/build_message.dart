import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class BuildMessage extends StatelessWidget {
  const BuildMessage({
    super.key,
    required this.message,
    required this.userModel,
    required this.isMine,
  });
  final MessageModel message;
  final UserModel userModel;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            if (isMine) const Spacer(),
            Container(
              margin: EdgeInsets.only(
                left: isMine ? 50 : 10,
                right: isMine ? 10 : 50,
                top: 5,
                bottom: 5,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: isMine ? AppColors.primaryBlue : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message.msg,
                style: TextStyle(
                  color: isMine ? Colors.white : Colors.black,
                ),
              ),
            ),
            CustomUserAvatar(
              avatarLink: userModel.imgUrl,
              isWithOnline: true,
              isOnline: true,
            ),
          ],
        ),
      ),
    );
  }
}
