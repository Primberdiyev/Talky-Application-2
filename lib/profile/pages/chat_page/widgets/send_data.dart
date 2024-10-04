import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/providers/chat_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class SendData extends StatefulWidget {
  const SendData({
    super.key,
  });

  @override
  State<SendData> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendData> {
  final TextEditingController _controller = TextEditingController();
  void _sendMessage(ChatProvider provider) async {
    if (_controller.text.isNotEmpty) {
      await provider.sendMessage(provider.reveiverId!, _controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SizedBox(
              height: 54,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    labelText: 'Message',
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryBlue)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send_rounded),
                      color: AppColors.sendIconColor,
                      onPressed: () => _sendMessage(provider),
                    )),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBlue,
              ),
              child: InkWell(
                onTap: () {
                  showPopover(
                      context: context,
                      width: 60,
                      height: 250,
                      backgroundColor: Colors.transparent,
                      direction: PopoverDirection.top,
                      bodyBuilder: (context) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 60,
                              width: 60,
                              alignment: Alignment.centerRight,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                          ],
                        );
                      });
                },
                child: Image.asset('assets/images/plus.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
