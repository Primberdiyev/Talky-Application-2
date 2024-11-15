import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:talky_aplication_2/features/profile/pages/create_group_page/create_group_page.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';
import 'package:talky_aplication_2/unilities/app_texts.dart';

class CreateGroup extends StatelessWidget {
  const CreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: ListTile(
        onTap: () {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (_) => CreateGroupPage(),
          );
        },
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 15,
        ),
        leading: SvgPicture.asset(
          AppIcons.chatGroup.icon,
        ),
        title: Text(
          AppTexts.createGroup,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.blackText,
          ),
        ),
        trailing: SvgPicture.asset(
          AppIcons.chevron.icon,
        ),
      ),
    );
  }
}
