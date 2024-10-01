import 'package:flutter/material.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Expanded(
          child: SizedBox(
            height: 54,
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.send_rounded,
                    color: AppColors.sendIconColor,
                  )),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
            onPressed: () {},
            icon: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBlue,
              ),
              child: Image.asset('assets/images/plus.png'),
            ))
      ],
    );
  }
}
