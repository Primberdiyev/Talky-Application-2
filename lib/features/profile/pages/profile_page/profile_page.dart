import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/services/user_state_service.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_profile_app_bar.dart';
import 'package:talky_aplication_2/features/profile/pages/profile_page/widgets/action_button.dart';
import 'package:talky_aplication_2/features/profile/pages/profile_page/widgets/list_users.dart';
import 'package:talky_aplication_2/features/profile/providers/all_users_provider.dart';
import 'package:talky_aplication_2/features/profile/providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<UserProvider>().getUserModel();
        UserStateService.instance.startTimer();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomProfileAppBar(),
          body: provider.usersData != null
              ? const Column(
                  children: [
                    SizedBox(height: 35),
                    // Expanded(
                    //   child: ListUsers(),
                    // )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ActionButtonProfile(),
        );
      },
    );
  }
}
