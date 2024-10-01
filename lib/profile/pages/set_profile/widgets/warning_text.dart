import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';

class WarningText extends StatelessWidget {
  const WarningText({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (context, provider, child) {
        return  Offstage(
          offstage: !provider.isNameEmpty,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Please Enter your name, it is required',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
