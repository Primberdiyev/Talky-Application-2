import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 32,
        right: 33,
        bottom: 38,
        top: 38,
      ),
      child: const Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1,
              color: Color(0xFF58616A),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'or',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              color: Color(0xFF58616A),
            ),
          ),
        ],
      ),
    );
  }
}
