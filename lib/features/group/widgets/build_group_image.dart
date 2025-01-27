import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/image_message.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/group/models/group_message_model.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class BuildGroupImage extends StatelessWidget {
  const BuildGroupImage({
    super.key,
    required this.isMine,
    required this.messageModel,
  });
  final bool isMine;
  final GroupMessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: isMine
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ImageMessage(
                    isMine: isMine,
                    link: messageModel.message,
                  ),
                  CustomUserAvatar(
                    avatarLink: messageModel.imageUrl,
                    isOnline: true,
                    isWithOnline: true,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      final provider = context.read<ChatProvider>();
                      provider.changeReceiverUser(receiverId: messageModel.id);
                      Navigator.pushNamed(
                        context,
                        NameRoutes.receiverUser,
                      );
                    },
                    child: CustomUserAvatar(
                      avatarLink: messageModel.imageUrl,
                      isOnline: true,
                      isWithOnline: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ImageMessage(
                      isMine: isMine,
                      link: messageModel.message,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
