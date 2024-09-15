import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
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
              child: Image.file(provider.image!),
            );
    });
  }
}
