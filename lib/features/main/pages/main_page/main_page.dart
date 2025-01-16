import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/services/user_state_service.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_app_bar.dart';
import 'package:talky_aplication_2/features/main/pages/main_page/widgets/action_button_profile.dart';
import 'package:talky_aplication_2/features/main/pages/main_page/widgets/friends_list.dart';
import 'package:talky_aplication_2/features/main/pages/main_page/widgets/groups.dart';
import 'package:talky_aplication_2/features/main/providers/user_provider.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';

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
        final provider = context.read<UserProvider>();
        provider.getUserModel();

        //    UserStateService.instance.startTimer();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        UserStateService.instance.stopTimer();
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              userModel: provider.userModel,
            ),
            body: const Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      child: Text(ImportantTexts.chats),
                    ),
                    Tab(
                      child: Text(ImportantTexts.groups),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FriendsList(),
                      Groups(),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: const ActionButtonProfile(),
          ),
        );
      },
    );
  }
}
