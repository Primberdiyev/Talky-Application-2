import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';

class BuildMessage extends StatelessWidget {
  const BuildMessage({
    required this.message,
    required this.userModel,
    required this.isMine,
    super.key,
  });
  final MessageModel message;
  final UserModel userModel;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case TypeMessage.text:
        return Expanded(
          child: Row(
            children: [
              CustomUserAvatar(
                avatarLink: userModel.imgUrl,
                isWithOnline: true,
              ),
              ListTile(
                title: Align(
                  alignment:
                      isMine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.width * 0.5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message.msg,
                      style: TextStyle(
                        color: isMine ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
