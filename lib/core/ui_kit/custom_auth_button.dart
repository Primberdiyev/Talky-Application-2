import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    this.iconPath,
    required this.text,
    required this.function,
    required this.isLoading,
    required this.buttonColor,
    required this.textColor,
    required this.textFontSize,
  });
  final String? iconPath;
  final String text;
  final Function() function;
  final bool isLoading;
  final Color buttonColor;
  final Color textColor;
  final double textFontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
        ),
        padding: const EdgeInsets.symmetric( horizontal: 34),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: iconPath != null ? AppColors.primaryBlue : Colors.white,
                ),
              )
            : Row(
                children: [
                  if (iconPath != null) SvgPicture.asset(iconPath!),
                  Expanded(
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: textFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
