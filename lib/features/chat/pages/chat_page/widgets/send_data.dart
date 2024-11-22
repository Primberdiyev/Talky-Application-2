import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class SendData extends StatefulWidget {
  const SendData({
    required this.controller,
    super.key,
    this.sendFunction,
  });
  final Function()? sendFunction;
  final TextEditingController controller;

  @override
  State<SendData> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendData> {
  Future<void> _sendMessage(ChatProvider provider) async {
    if (widget.controller.text.isNotEmpty) {
      await provider.sendMessage(
        provider.receiverUser?.id ?? '',
        widget.controller.text,
      );
      widget.controller.clear();
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 98),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SizedBox(
              height: 54,
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryBlue),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send_rounded),
                    color: AppColors.sendIconColor,
                    onPressed: () => widget.sendFunction?.call() ?? _sendMessage(provider),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
