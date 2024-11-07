import 'package:flutter/material.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final suffixIcon;
  final VoidCallback? suffixTab;
  final EdgeInsets? contentPadding;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.suffixTab,
    this.contentPadding,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColors.primaryBlue,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.lightBlack,
              width: 1,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primaryBlue,
            width: 1,
          ),
        ),
        contentPadding: contentPadding ?? EdgeInsets.all(11),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.lightBlack,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixTab,
                icon: suffixIcon ?? SizedBox.shrink(),
              )
            : null,
      ),
    );
  }
}
