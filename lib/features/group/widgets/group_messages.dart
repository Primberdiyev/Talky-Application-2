import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/group/services/receive_messages_service.dart';
import 'package:talky_aplication_2/features/group/widgets/build_message.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';

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
  Map<String, dynamic> usersImages = {};
  Future<String>? getUserImg(String id) async {
    if (usersImages.containsKey(id)) {
      return usersImages[id];
    }

    try {
      final response = await UserDataService.instance.getUserDoc(id: id);
      final user = UserModel.fromJson(response.data() ?? {});
      usersImages[user.id ?? ""] = user.imgUrl;
      return user.imgUrl ?? '';
    } catch (e) {
      log('xato ${e.toString()}');
      return '';
    }
  }

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
        final messages = snapshot.data?.docs ?? [];
        return Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = MessageModel.fromJson(
                messages[messages.length - 1 - index].data(),
              );
              final isMine =
                  message.fromId == userDataService.auth.currentUser?.uid;
              return FutureBuilder(
                future: getUserImg(message.fromId),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox.shrink(),
                    );
                  } else if (userSnapshot.hasError || !userSnapshot.hasData) {
                    return Text(locale.errorGettingMessage);
                  }
                  final String? userImage = userSnapshot.data;
                  return BuildMessage(
                    message: message,
                    userImage: userImage,
                    isMine: isMine,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
