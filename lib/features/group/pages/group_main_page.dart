import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/widgets/custom_app_bar.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/send_data.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/features/group/providers/group_chat_provider.dart';
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        text: widget.groupModel.title,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GroupMessages(
            groupId: widget.groupModel.id ?? '',
          ),
          ChangeNotifierProvider(
            create: (context) => GroupChatProvider(),
            child: Consumer<GroupChatProvider>(builder: (
              context,
              provider,
              child,
            ) {
              return SendData(
                controller: controller,
                imageFunction: () {},
                fileFunction: (){},
                sendFunction: () async {
                  await provider.sendMessageGroup(
                    msg: controller.text,
                    id: widget.groupModel.id ?? "",
                  );
                  controller.clear();
                },
              );
            }),
          ),
          const SizedBox(height: 31),
        ],
      ),
    );
  }
}
