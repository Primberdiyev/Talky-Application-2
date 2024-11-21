import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/main/pages/set_profile/widgets/custom_text_fileld.dart';
import 'package:talky_aplication_2/features/main/providers/profile_page_provider.dart';

class InputName extends StatelessWidget {
  const InputName({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return CustomTextFileld(
          controller: controller,
          labelText: 'Enter your name or nickname',
          getFromGoogle: true,
        );
      },
    );
  }
}
