import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32),
      child: Row(
        children: [
          Container(
            height: 1,
            width: (MediaQuery.of(context).size.width - 175) / 2,
            color: const Color(0xFF58616A),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'or',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            height: 1,
            width: (MediaQuery.of(context).size.width - 154) / 2,
            color: const Color(0xFF58616A),
          ),
        ],
      ),
    );
  }
}
