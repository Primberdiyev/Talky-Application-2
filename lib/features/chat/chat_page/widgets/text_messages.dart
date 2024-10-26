import 'package:flutter/material.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class TextMessages extends StatefulWidget {
  final bool isMine;
  final message;
  const TextMessages({super.key, required this.isMine, required this.message});

  @override
  State<TextMessages> createState() => _TextMessagesState();
}

class _TextMessagesState extends State<TextMessages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7.5, top: 7.5),
      alignment: widget.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ListTile(
        title: Align(
          alignment:
              widget.isMine ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(10),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5),
            decoration: BoxDecoration(
              color:
                  widget.isMine ? AppColors.primaryBlue : AppColors.chatColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.message,
              style: TextStyle(
                color: widget.isMine ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
