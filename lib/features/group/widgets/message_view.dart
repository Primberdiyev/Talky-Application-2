import 'package:flutter/material.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';

class MessageView extends StatelessWidget {
  const MessageView({
    super.key,
    required this.isMine,
    required this.message,
  });
  final bool isMine;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        message,
        style: TextStyle(
          color: isMine ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
