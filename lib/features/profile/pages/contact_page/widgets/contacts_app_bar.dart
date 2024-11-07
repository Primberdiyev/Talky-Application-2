import 'package:flutter/material.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onDone;
  final String centerText;
  final bool? isDoneActive;

  const ContactsAppBar({
    super.key,
    this.onDone,
    required this.centerText,
    this.isDoneActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: Theme.of(context).textButtonTheme.style?.copyWith(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            centerText,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.blackText,
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
            visible: onDone != null,
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            child: TextButton(
              onPressed: onDone,
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDoneActive!
                      ? AppColors.primaryBlue
                      : AppColors.lightBlack,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
