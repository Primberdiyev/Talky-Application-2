import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/account_page_provider.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountPageProvider>(builder: (context, provider, child) {
      return provider.image == null
          ? InkWell(
              onTap: () async {
                final picture =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picture != null) {
                  provider.updateImage(picture);
                }
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 95,
                    backgroundColor: const Color(0xFFF0F0F0),
                    child: Image.asset(
                      'assets/images/User.png',
                      width: 40,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF377DFF),
                      radius: 25,
                      child: Image.asset(
                        'assets/images/Edit.png',
                        width: 24,
                      ),
                    ),
                  )
                ],
              ),
            )
          : ClipOval(
              child: Image.file(
                File(provider.image!.path),
                height: 190,
                width: 190,
                fit: BoxFit.cover,
              ),
            );
    });
  }
}
