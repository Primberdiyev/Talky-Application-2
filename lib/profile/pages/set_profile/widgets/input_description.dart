import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/widgets/custom_text_fileld.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';

class InputDescription extends StatefulWidget {
  const InputDescription({super.key});

  @override
  State<InputDescription> createState() => _InputNameState();
}

class _InputNameState extends State<InputDescription> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (context, provider, child) {
      return CustomTextFileld(
          controller: provider.descriptionController,
          labelText: 'Enter a description');
    });
  }
}
