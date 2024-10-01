import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

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
                  backgroundImage: provider.currentUser != null &&
                          provider.imgUrls['currentUserImgUrl'] != null
                      ? NetworkImage(
                          provider.imgUrls['currentUserImgUrl']!,
                        )
                      : const AssetImage('assets/images/User.png'),
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
              onPressed: () {
                Navigator.pushReplacementNamed(context, NameRoutes.onlinUsers);
              },
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
