import 'package:flutter/material.dart';

class CreateGroup extends StatelessWidget {
  const CreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.group),
        const Text(
          "Start a new group chat",
          style: TextStyle(color: Color(0xFF243443), fontSize: 14),
        ),
        Image.asset("assets/images/Chevron.png")
      ],
    );
  }
}
