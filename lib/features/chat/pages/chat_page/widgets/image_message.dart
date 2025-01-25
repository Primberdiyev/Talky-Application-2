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
    final imageSize = MediaQuery.of(context).size.height * 0.15;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: link,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.fill,
          imageBuilder: (context, imageProvider) {
            return Container(
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
