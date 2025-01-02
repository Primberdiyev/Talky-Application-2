import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/action_button.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/main/providers/user_provider.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';

class SendData extends StatefulWidget {
  const SendData({
    required this.controller,
    super.key,
    this.sendFunction,
    required this.imageFunction,
    required this.fileFunction,
  });
  final Function()? sendFunction;
  final TextEditingController controller;
  final VoidCallback imageFunction;
  final VoidCallback fileFunction;

  @override
  State<SendData> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendData> {
  Future<void> _sendMessage() async {
    final provider = context.read<ChatProvider>();
    final userProvider = context.read<UserProvider>();
    final receiverId = provider.receiverUser?.id;
    if (widget.controller.text.isNotEmpty) {
      await provider.sendMessage(
        receiverId ?? '',
        widget.controller.text,
      );
      widget.controller.clear();
      final List<String> usersId = userProvider.chattingUsersId;
      if (!usersId.contains(receiverId)) {
        userProvider.addChattingUser(provider.receiverUser ?? {} as UserModel);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                labelText: locale.message,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryBlue),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send_rounded),
                  color: AppColors.sendIconColor,
                  onPressed: () =>
                      widget.sendFunction?.call() ?? _sendMessage(),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ActionButton(
            imageFunction: widget.imageFunction,
            fileFunction: widget.fileFunction,
          ),
        ],
      ),
    );
  }
}
