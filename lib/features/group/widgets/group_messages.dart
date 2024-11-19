import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/group/providers/receive_messages_provider.dart';
import 'package:talky_aplication_2/features/profile/models/message_model.dart';

class GroupMessages extends StatefulWidget {
  const GroupMessages({super.key, required this.titleGroup});
  final String titleGroup;

  @override
  State<GroupMessages> createState() => _GroupMessagesState();
}

class _GroupMessagesState extends State<GroupMessages> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiveMessagesProvider>(
        builder: (context, provider, child) {
      return Expanded(
        child: StreamBuilder(
            stream: provider.getAllGroupMessages(widget.titleGroup),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                Text('Error from getting message');
              }
              final messages = snapshot.data!.docs;
              return ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = MessageModel.fromJson(
                      messages[messages.length - 1 - index].data());
                  bool isMine = message.fromId == auth.currentUser?.uid;
                //  bool 
                  switch (message.type) {
                    case TypeMessage.text:
                      return Row(
                        children: [
                       //   CustomUserAvatar(avatarLink: message,)
                        ],
                      );
                    default:
                      SizedBox.shrink();
                  }
                },
              );
            }),
      );
    });
  }
}
