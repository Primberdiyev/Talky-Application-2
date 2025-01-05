import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/group/services/receive_messages_service.dart';
import 'package:talky_aplication_2/features/group/widgets/build_message.dart';
import 'package:talky_aplication_2/features/main/providers/group_provider.dart';

class GroupMessages extends StatefulWidget {
  const GroupMessages({required this.groupId, super.key});
  final String groupId;

  @override
  State<GroupMessages> createState() => _GroupMessagesState();
}

class _GroupMessagesState extends State<GroupMessages> {
  final userDataService = UserDataService.instance;
  final User? currentUser = UserDataService.instance.auth.currentUser;
  final ReceiveMessagesService receiveMessagesService =
      ReceiveMessagesService();

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return StreamBuilder(
      stream: receiveMessagesService.getAllGroupMessages(widget.groupId),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Text(locale.noData);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text(locale.errorGettingMessage);
        }
        final messages = snapshot.data ?? [];
        return Consumer<GroupProvider>(builder: (
          context,
          provider,
          child,
        ) {
          return Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - index - 1];
                final isMine =
                    message.id == userDataService.auth.currentUser?.uid;
                return BuildMessage(
                  message: message,
                  isMine: isMine,
                );
              },
            ),
          );
        });
      },
    );
  }
}
