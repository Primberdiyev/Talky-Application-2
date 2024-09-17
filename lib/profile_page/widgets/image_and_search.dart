import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';

class ImageAndSearch extends StatelessWidget {
  const ImageAndSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 30, top: 54, right: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFFF0F0F0),
                  child: provider.image != null
                      ? ClipOval(
                          child: Image.file(
                            File(
                              provider.image!.path,
                            ),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset('assets/images/User.png', width: 25),
                ),
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.green,
                  ),
                )
              ],
            ),
            const Text(
              'Chats',
              style: TextStyle(
                color: Color(0xFF243443),
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/Search.png',
                width: 24,
              ),
            )
          ],
        ),
      );
    });
  }
}
