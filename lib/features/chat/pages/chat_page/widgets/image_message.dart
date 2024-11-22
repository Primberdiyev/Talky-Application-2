import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    required this.isMine,
    required this.link,
    super.key,
  });
  final bool isMine;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 7.5),
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: link,
          width: 125,
          height: 125,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
