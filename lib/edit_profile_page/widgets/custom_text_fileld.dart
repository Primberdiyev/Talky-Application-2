import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/edit_profile_page_provider.dart';

class CustomTextFileld extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  const CustomTextFileld({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  State<CustomTextFileld> createState() => _InputNameState();
}

class _InputNameState extends State<CustomTextFileld> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditPageProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 28, top: 18),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(
              color: Color(0xFFAAB0B7),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF377DFF),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
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
