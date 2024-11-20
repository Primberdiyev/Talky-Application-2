import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.text,
    this.imgUrl,
    this.function,
    super.key,
  });
  final String? text;
  final String? imgUrl;
  final Function()? function;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 110,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text(
            'Back',
            style: TextStyle(
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
              color: Color(0xffE5F1FF),
            ),
            child: Image.asset('assets/images/Back.png'),
          ),
        ),
      ),
      leadingWidth: 110,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          text ?? '',
          style: const TextStyle(
            color: Color(0xff243443),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: [
        if (imgUrl != null)
          Padding(
            padding: const EdgeInsets.only(right: 30, top: 30),
            child: Stack(
              children: [
                InkWell(
                  onTap: () => function?.call(),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl ?? '',
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
