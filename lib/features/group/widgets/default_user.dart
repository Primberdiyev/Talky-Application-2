import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talky_aplication_2/utils/app_icons.dart';

class DefaultUser extends StatelessWidget {
  const DefaultUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SvgPicture.asset(
        AppIcons.userDefault.icon,
        fit: BoxFit.cover,
        height: 50,
        width: 50,
      ),
    );
  }
}
