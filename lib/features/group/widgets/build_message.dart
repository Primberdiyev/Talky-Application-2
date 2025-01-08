import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/group/models/group_message_model.dart';
import 'package:talky_aplication_2/features/group/widgets/message_view.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class BuildMessage extends StatelessWidget {
  const BuildMessage({
    super.key,
    required this.message,
    required this.isMine,
  });
  final GroupMessageModel message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final userImageUrl = message.imageUrl;
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
                    message: message.message,
                  ),
                  CustomUserAvatar(
                    avatarLink: userImageUrl,
                    isWithOnline: true,
                    isOnline: true,
                  ),
                ],
              )
            : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final provider = context.read<ChatProvider>();
                      provider.changeReceiverUser(receiverId: message.id);
                      Navigator.pushNamed(
                        context,
                        NameRoutes.receiverUser,
                      );
                    },
                    child: CustomUserAvatar(
                      avatarLink: userImageUrl,
                      isWithOnline: true,
                      isOnline: true,
                    ),
                  ),
                  MessageView(
                    isMine: isMine,
                    message: message.message,
                  ),
                  const Spacer(),
                ],
              ),
      ),
    );
  }
}
