import 'package:flutter/material.dart';

class CustomTextFileld extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool? getFromGoogle;
  const CustomTextFileld(
      {super.key,
      required this.controller,
      required this.labelText,
      this.getFromGoogle});

  @override
  State<CustomTextFileld> createState() => _CustomTextFileldState();
}

class _CustomTextFileldState extends State<CustomTextFileld> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 18),
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
  }
}
