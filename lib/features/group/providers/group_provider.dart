import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/features/profile/models/message_model.dart';

class GroupProvider extends BaseChangeNotifier {
  final firebaseFirestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future sendMessageGroup({
    required String msg,
    required String groupTitle,
  }) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final message = MessageModel(
      toId: '',
      msg: msg,
      read: 'false',
      type: TypeMessage.text,
      fromId: auth.currentUser?.uid ?? '',
      sent: time,
      sentTime: DateTime.now().toString(),
    );
    final ref = firebaseFirestore.collection('groups/$groupTitle/messages/');
    try {
      await ref.doc(time).set(message.toJson());
    } catch (e) {
      log('error sending message to goup $e');
    }
  }
}
