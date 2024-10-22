import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/models/user_model.dart';
import 'package:talky_aplication_2/profile/pages/profile_page/widgets/list_users.dart';
import 'package:talky_aplication_2/profile/pages/profile_page/widgets/profile_app_bar.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<ProfilePageProvider>().getUserCollection();
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
      final provider = Provider.of<ProfilePageProvider>(context, listen: false);
      final userData = UserModel(closingTime: Timestamp.fromDate(closingTime), isOnline: false);
      await FirebaseFirestore.instance
          .collection("User")
          .doc(provider.currentUser?.uid)
          .update(userData.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: ProfileAppBar(),
          body: provider.usersData != null
              ? const Column(
                  children: [
                    SizedBox(height: 35),
                    Expanded(
                      child: ListUsers(
                        isWithOnline: false,
                      ),
                    )
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 34, left: 28),
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
