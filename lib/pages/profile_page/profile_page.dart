import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/pages/profile_page/widgets/image_and_search.dart';
import 'package:talky_aplication_2/pages/profile_page/widgets/list_users.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfilePageProvider>(context, listen: false);
    provider.getUserCollection();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    final closingTime = DateTime.now();
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      final provider = Provider.of<ProfilePageProvider>(context);
      await FirebaseFirestore.instance
          .collection("User")
          .doc(provider.currentUser?.uid)
          .update({'closingTime': closingTime});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: provider.usersData != null
              ? const Column(
                  children: [
                    ImageAndSearch(),
                    Expanded(
                      child: ListUsers(),
                    )
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
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
      },
    );
  }
}
