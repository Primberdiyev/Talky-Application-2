import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_app_bar.dart';
import 'package:talky_aplication_2/features/profile/pages/main_page/widgets/action_button.dart';
import 'package:talky_aplication_2/features/profile/pages/main_page/widgets/friends_list.dart';
import 'package:talky_aplication_2/features/profile/providers/user_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MainPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<UserProvider>().getUserModel();
        //   UserStateService.instance.startTimer();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            userModel: provider.userModel,
          ),
          body: provider.chattingUsers != null
              ? const Column(
                  children: [
                    SizedBox(height: 35),
                    Expanded(
                      child: FriendsList(),
                    )
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
