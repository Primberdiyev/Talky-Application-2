import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/profile/models/message_model.dart';

class ChatProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firsestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  User get user => auth.currentUser!;
  getConversatioId(String id) {
    return user.uid.hashCode <= id.hashCode
        ? '${user.uid}_$id'
        : '${id}_${user.uid}';
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(receiverId) {
    return firsestore
        .collection('chats/${getConversatioId(receiverId)}/messages/')
        .snapshots();
  }

  Future<void> sendMessage(String receiverId, String msg) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final MessageModel message = MessageModel(
        toId: receiverId,
        msg: msg,
        read: 'false',
        type: Type.text,
        fromId: user.uid,
        sent: time);

    final ref = firsestore
        .collection('chats/${getConversatioId(receiverId)}/messages/');
    try {
      await ref.doc(time).set(message.toJson());
    } catch (_) {
      throw Exception();
    }
  }
}
