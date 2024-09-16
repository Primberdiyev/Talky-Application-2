import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/account_page_provider.dart';

class InputDescription extends StatefulWidget {
  const InputDescription({super.key});

  @override
  State<InputDescription> createState() => _InputNameState();
}

class _InputNameState extends State<InputDescription> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountPageProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 28, top: 18),
        child: TextField(
          controller: provider.descriptionController,
          decoration: const InputDecoration(
            labelText: 'Enter a description',
            labelStyle: TextStyle(
              color: Color(0xFFAAB0B7),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF377DFF),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFAAB0B7),
              ),
            ),
          ),
        ),
      );
    });
  }
}
