import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hintText,
    required this.controller,
    super.key,
    this.suffixIcon,
    this.suffixTab,
    this.contentPadding,
    this.onChanged,
  });
  final String hintText;
  final Widget? suffixIcon;
  final VoidCallback? suffixTab;
  final EdgeInsets? contentPadding;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Consumer<ValueStateProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return TextField(
          controller: controller,
          obscureText: !provider.isHideText,
          onChanged: onChanged,
          cursorColor: AppColors.primaryBlue,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: controller.text.isEmpty
                    ? Colors.red
                    : const Color(
                        0xFFAAB0B7,
                      ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue,
              ),
            ),
            contentPadding: contentPadding ?? const EdgeInsets.all(11),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: suffixTab,
                    icon: suffixIcon ?? const SizedBox.shrink(),
                  )
                : null,
          ),
        );
      },
    );
  }
}
