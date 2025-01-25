import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';
import 'package:talky_aplication_2/utils/app_icons.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.imageFunction,
    required this.fileFunction,
  });
  final VoidCallback imageFunction;
  final VoidCallback fileFunction;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 12,
            right: 12,
          ),
          child: SpeedDial(
            activeIcon: Icons.close,
            backgroundColor: AppColors.primaryBlue,
            buttonSize: const Size.fromRadius(30),
            childrenButtonSize: const Size(60, 60),
            spaceBetweenChildren: 20,
            children: [
              SpeedDialChild(
                shape: const StadiumBorder(),
                child: SvgPicture.asset(
                  AppIcons.voiceIcon.icon,
                ),
                backgroundColor: Colors.white,
                onTap: () {},
              ),
              SpeedDialChild(
                shape: const StadiumBorder(),
                child: SvgPicture.asset(AppIcons.cameraIcon.icon),
                backgroundColor: Colors.white,
                onTap: imageFunction,
              ),
              SpeedDialChild(
                shape: const StadiumBorder(),
                child: SvgPicture.asset(AppIcons.fileIcon.icon),
                backgroundColor: Colors.white,
                onTap:fileFunction,
              ),
            ],
            child: SvgPicture.asset(AppIcons.plusIcon.icon),
          ),
        );
      },
    );
  }
}
