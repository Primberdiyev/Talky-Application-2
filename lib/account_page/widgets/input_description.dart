import 'package:flutter/material.dart';

class InputDescription extends StatefulWidget {
  const InputDescription({super.key});

  @override
  State<InputDescription> createState() => _InputNameState();
}

class _InputNameState extends State<InputDescription> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 28, top: 18),
      child: TextField(
        decoration: InputDecoration(
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
  }
}
