import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class GeneralSignButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final Function() function;
  final bool isLoading;

  const GeneralSignButton({
    super.key,
    required this.text,
    required this.function,
    required this.imagePath,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: function,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.signInFontColor,
          ),
          margin: const EdgeInsets.only(bottom: 38),
          child: isLoading
              ? SizedBox(
                  child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 23),
                        child: Image.asset(
                          imagePath,
                          width: 24,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Text(
                          text,
                          style: const TextStyle(
                            color: AppColors.signInTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      );
    });
  }
}
