import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/send_data.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/features/group/providers/group_chat_provider.dart';
import 'package:talky_aplication_2/features/group/widgets/group_app_bar.dart';
import 'package:talky_aplication_2/features/group/widgets/group_messages.dart';
import 'package:talky_aplication_2/features/main/providers/user_provider.dart';

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
      appBar: GroupAppBar(
        text: widget.groupModel.title,
        imageLink: widget.groupModel.imgUrl ?? '',
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
              final userProvider = context.read<UserProvider>();
              return SendData(
                controller: controller,
                imageFunction: () async {
                  await provider.getImageGroup(
                    groupId: widget.groupModel.id ?? "",
                    usermodel: userProvider.userModel,
                  );
                },
                fileFunction: () {},
                sendFunction: () async {
                  await provider.sendMessageGroup(
                    userModel: userProvider.userModel,
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
