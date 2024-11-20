import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.function,
    required this.isLoading,
    required this.buttonColor,
  });
  final String iconPath;
  final String text;
  final Function() function;
  final bool isLoading;
  final Color buttonColor;

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
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 34),
        child: !isLoading
            ? Row(
                children: [
                  SvgPicture.asset(iconPath),
                  Expanded(
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: AppColors.blackText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
      ),
    );
  }
}
