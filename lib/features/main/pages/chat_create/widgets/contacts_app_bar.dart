import 'package:flutter/material.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContactsAppBar({
    required this.centerText,
    super.key,
    this.onDone,
    this.isDoneActive = false,
    this.loading = false,
  });
  final Function()? onDone;
  final String centerText;
  final bool isDoneActive;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: Theme.of(context).textButtonTheme.style?.copyWith(
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
            child: const Text(
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
            style: const TextStyle(
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
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButton(
                    onPressed: onDone,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDoneActive
                            ? AppColors.primaryBlue
                            : AppColors.lightBlack,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
