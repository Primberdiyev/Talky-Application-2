import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/app.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/profile/pages/profile_page/widgets/list_users.dart';
import 'package:talky_aplication_2/features/profile/pages/profile_page/widgets/profile_app_bar.dart';
import 'package:talky_aplication_2/features/profile/providers/profile_page_provider.dart';

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
      final userData = UserModel(
          closingTime: Timestamp.fromDate(closingTime), isOnline: false);
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
          appBar: const ProfileAppBar(),
          body: provider.usersData != null
              ?  const Column(
                  children: [
                    SizedBox(height: 35),
                     Expanded(
                      child: ListUsers(isWithOnline: false),
                    )
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0, bottom: 34),
                child: PopupMenuButton<String>(
                  offset: const Offset(0, -60),
                  onSelected: (String result) {
                    print('Selected: $result');
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      child: SizedBox(
                        height: 30,
                        width: 50,
                        child: InkWell(
                          onTap: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              MyApp.restartApp(context);
                            });
                          },
                          child: const Text('Log Out'),
                        ),
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 34, right: 28),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFF377DFF),
                  onPressed: () {},
                  child: Image.asset(
                    'assets/images/FloatingMenu.png',
                    width: 40,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
