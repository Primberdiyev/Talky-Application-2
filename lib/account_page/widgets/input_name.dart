import 'package:flutter/material.dart';

class InputName extends StatefulWidget {
  const InputName({super.key});

  @override
  State<InputName> createState() => _InputNameState();
}

class _InputNameState extends State<InputName> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 28, top: 50),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Enter your name or nickname',
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
  }
}
