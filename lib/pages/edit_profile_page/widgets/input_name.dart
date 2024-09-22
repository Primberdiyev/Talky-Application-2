import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/pages/edit_profile_page/widgets/custom_text_fileld.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';

class InputName extends StatelessWidget {
  const InputName({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (context, provider, child) {
      return CustomTextFileld(controller: provider.nameController, labelText: 'Enter your name or nickname');
    });
  }
}
