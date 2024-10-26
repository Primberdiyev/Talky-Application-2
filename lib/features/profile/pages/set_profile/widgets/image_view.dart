import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/profile/providers/profile_page_provider.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (context, provider, child) {
      final userGoogleImg = provider.currentUser?.photoURL;
      return Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 32),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 95,
              backgroundColor: const Color(0xFFF0F0F0),
              backgroundImage: provider.image != null
                  ? FileImage(File(provider.image!.path))
                  : userGoogleImg != null
                      ? NetworkImage(userGoogleImg)
                      : null,
              child: provider.image == null && userGoogleImg == null
                  ? SvgPicture.asset(
                      "assets/icons/User.svg",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () async {
                  final picture = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (picture != null) {
                    await provider.updateImage(picture);
                  }
                },
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF377DFF),
                  radius: 25,
                  child: Image.asset(
                    'assets/images/Edit.png',
                    width: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
