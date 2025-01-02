import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/group/widgets/message_view.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';

class BuildMessage extends StatelessWidget {
  const BuildMessage({
    super.key,
    required this.message,
    required this.userImage,
    required this.isMine,
  });
  final MessageModel message;
  final String? userImage;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: isMine
            ? Row(
                children: [
                  const Spacer(),
                  MessageView(
                    isMine: isMine,
                    message: message.msg,
                  ),
                  CustomUserAvatar(
                    avatarLink: userImage,
                    isWithOnline: true,
                    isOnline: true,
                  ),
                ],
              )
            : Row(
                children: [
                  CustomUserAvatar(
                    avatarLink: userImage,
                    isWithOnline: true,
                    isOnline: true,
                  ),
                  MessageView(
                    isMine: isMine,
                    message: message.msg,
                  ),
                  const Spacer(),
                ],
              ),
        //  Row(
        //   children: [
        //     if (isMine) const Spacer(),
        //     CustomUserAvatar(
        //       avatarLink: userImage,
        //       isWithOnline: true,
        //       isOnline: true,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
