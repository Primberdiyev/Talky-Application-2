import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Container(
      padding: const EdgeInsets.only(
        left: 32,
        right: 33,
        bottom: 38,
        top: 38,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              thickness: 1,
              color: Color(0xFF58616A),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              locale.or,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const Expanded(
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
