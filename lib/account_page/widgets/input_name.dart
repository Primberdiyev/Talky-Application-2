import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';

class InputName extends StatefulWidget {
  const InputName({super.key});

  @override
  State<InputName> createState() => _InputNameState();
}

class _InputNameState extends State<InputName> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 28, top: 50),
        child: TextField(
          controller: provider.nameController,
          decoration: const InputDecoration(
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
    });
  }
}
