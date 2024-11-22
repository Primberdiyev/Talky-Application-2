import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/group/providers/receive_messages_provider.dart';
import 'package:talky_aplication_2/features/group/widgets/build_message.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';

class GroupMessages extends StatefulWidget {
  const GroupMessages({required this.titleGroup, super.key});
  final String titleGroup;

  @override
  State<GroupMessages> createState() => _GroupMessagesState();
}

class _GroupMessagesState extends State<GroupMessages> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future<UserModel>? getUser(String id) async {
      try {
        final response = await UserDataService.instance.getUserDoc(id: id);
        return UserModel.fromJson(response.data() ?? {});
      } catch (e) {
        log('xato ${e.toString()}');
        return UserModel.fromJson({});
      }
    }

    return ChangeNotifierProvider(
      create: (context) => ReceiveMessagesProvider(),
      child: Consumer<ReceiveMessagesProvider>(
        builder: (
          context,
          provider,
          child,
        ) {
          return Expanded(
            child: StreamBuilder(
              stream: provider.getAllGroupMessages(widget.titleGroup),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Text("Ma'lumotn yo'q");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error from getting message');
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = MessageModel.fromJson(
                      messages[messages.length - 1 - index].data(),
                    );
                    final isMine = message.fromId == auth.currentUser?.uid;
                    return FutureBuilder(
                      future: getUser(message.fromId),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (userSnapshot.hasError ||
                            !userSnapshot.hasData) {
                          return const Text('error getting messages');
                        }
                        final user = userSnapshot.data!;
                        return BuildMessage(
                          message: message,
                          userModel: user,
                          isMine: isMine,
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
