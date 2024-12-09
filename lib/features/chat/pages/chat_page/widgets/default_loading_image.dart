import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talky_aplication_2/utils/app_icons.dart';

class DefaultLoadingImage extends StatelessWidget {
  const DefaultLoadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SvgPicture.asset(
        AppIcons.defaultImage.icon,
        fit: BoxFit.cover,
        height: 125,
        width: 125,
      ),
    );
  }
}
