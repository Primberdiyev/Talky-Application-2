import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/default_loading_image.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: link,
          width: 125,
          height: 125,
          fit: BoxFit.fill,
          imageBuilder: (context, imageProvider) {
            return Container(
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          errorWidget: (
            context,
            url,
            error,
          ) {
            return const DefaultLoadingImage();
          },
          placeholder: (context, url) {
            return const DefaultLoadingImage();
          },
        ),
      ),
    );
  }
}
