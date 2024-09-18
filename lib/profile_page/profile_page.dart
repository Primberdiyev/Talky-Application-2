import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile_page/widgets/image_and_search.dart';
import 'package:talky_aplication_2/profile_page/widgets/list_users.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfilePageProvider>(context, listen: false)
          .getUserCollection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: provider.usersData != null
            ? const Column(
                children: [
                  ImageAndSearch(),
                  Expanded(
                    child: ListUsers(),
                  ),
                ],
              )
            : const Center(
                child:
                    CircularProgressIndicator()), // Yuklash indikatorini markazda ko'rsatish uchun
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
    });
  }
}
