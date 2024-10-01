import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const CustomAppBar(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 110,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text(
            'Back',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff377DFF),
            ),
          ),
          icon: Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffE5F1FF),
            ),
            child: Image.asset('assets/images/Back.png'),
          ),
        ),
      ),
      leadingWidth: 110,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 30), 
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xff243443),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
