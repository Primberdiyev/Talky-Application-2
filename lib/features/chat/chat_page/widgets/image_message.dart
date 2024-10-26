import 'package:flutter/material.dart';

class ImageMessage extends StatelessWidget {
  final bool isMine;
  final link;
  const ImageMessage({super.key, required this.isMine, required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 28, left: 28, bottom: 7.5, top: 7.5),
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          link,
          width: 125,
          height: 125,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
