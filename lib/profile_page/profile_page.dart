import 'package:flutter/material.dart';
import 'package:talky_aplication_2/profile_page/widgets/image_and_search.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          ImageAndSearch(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 46, left: 28),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF377DFF),
          onPressed: () {},
          child: Image.asset(
            'assets/images/FloatingMenu.png',
            width: 40,
          ),
        ),
      ),
    );
  }
}
