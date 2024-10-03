import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/providers/chat_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class SendMessage extends StatefulWidget {
  final String receiverId;
  const SendMessage({super.key, required this.receiverId});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final TextEditingController _controller = TextEditingController();
  void _sendMessage(ChatProvider provider) async {
    if (_controller.text.isNotEmpty) {
      await provider.sendMessage(widget.receiverId, _controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.send_rounded,
                    color: AppColors.sendIconColor,
                  )),
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            _sendMessage(provider);
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryBlue,
            ),
            child: InkWell(
              child: Image.asset('assets/images/plus.png'),
            ),
          ),
        )
      ],
    );
  }
}
