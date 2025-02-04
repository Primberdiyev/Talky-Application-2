import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/utils/app_icons.dart';
import 'package:talky_aplication_2/utils/image_paths.dart';

class GroupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroupAppBar({
    super.key,
    required this.text,
    required this.imageLink,
  });
  final String? text;
  final String imageLink;
  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.transparent,
      leading: TextButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        label: Text(
          locale.back,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xff377DFF),
          ),
        ),
        icon: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE5F1FF),
          ),
          child: Image.asset(ImagePaths.back),
        ),
      ),
      leadingWidth: 110,
      centerTitle: true,
      title: Text(
        text ?? '',
        style: const TextStyle(
          color: Color(0xff243443),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        if (imageLink.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, NameRoutes.groupInfo);
              },
              child: CachedNetworkImage(
                imageUrl: imageLink,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
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
                  return SvgPicture.asset(AppIcons.userDefault.icon);
                },
                placeholder: (context, url) {
                  return SvgPicture.asset(AppIcons.userDefault.icon);
                },
              ),
            ),
          ),
        if (imageLink.isEmpty)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, NameRoutes.groupInfo);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 14),
              child: ClipOval(
                child: SvgPicture.asset(
                  AppIcons.userDefault.icon,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
