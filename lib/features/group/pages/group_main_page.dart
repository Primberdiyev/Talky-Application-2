import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_app_bar.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/action_button.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/send_data.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/features/group/providers/group_provider.dart';
import 'package:talky_aplication_2/features/group/widgets/group_messages.dart';

class GroupMainPage extends StatefulWidget {
  const GroupMainPage({required this.groupModel, super.key});
  final GroupModel groupModel;

  @override
  State<GroupMainPage> createState() => _GroupMainPageState();
}

class _GroupMainPageState extends State<GroupMainPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(groupModel: widget.groupModel),
      body: ChangeNotifierProvider(
        create: (context) => GroupProvider(),
        child: Consumer<GroupProvider>(
          builder: (
            context,
            provider,
            child,
          ) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GroupMessages(titleGroup: widget.groupModel.title ?? ''),
                SendData(
                  controller: controller,
                  sendFunction: () async {
                    await provider.sendMessageGroup(
                      msg: controller.text,
                      groupTitle: widget.groupModel.title ?? '',
                    );
                    controller.clear();
                  },
                ),
                const SizedBox(height: 31),
              ],
            );
          },
        ),
      ),
      floatingActionButton: const ActionButton(),
    );
  }
}
