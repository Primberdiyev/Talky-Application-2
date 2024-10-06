import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talky_aplication_2/profile/models/message_model.dart';
import 'package:uuid/uuid.dart';

class ChatProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? reveiverId;
  User get user => auth.currentUser!;
  String? lastMessage;
  String? reveiverName;
  File? imageFile;
  String? reveiverImgUrl;

  getConversatioId(String id) {
    return user.uid.hashCode <= id.hashCode
        ? '${user.uid}_$id'
        : '${id}_${user.uid}';
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(receiverId) {
    return firestore
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

    final ref =
        firestore.collection('chats/${getConversatioId(receiverId)}/messages/');
    try {
      await ref.doc(time).set(message.toJson());
    } catch (_) {
      throw Exception();
    }
  }

  setReceiverId({String? newId, String? imgUrl, String? name}) {
    reveiverId = newId;
    reveiverImgUrl = imgUrl;
    reveiverName = name;

    notifyListeners();
  }

  Stream<String> getLastMessage(String id) {
    return firestore
        .collection('chats/${getConversatioId(id)}/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first['msg'] ?? '';
      } else {
        return '';
      }
    });
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = const Uuid().v1();
    var refStorage = storage.ref().child('chatImages').child('$fileName.jpg');
    var uploadTask = await refStorage.putFile(imageFile!);
    String imgUrl = await uploadTask.ref.getDownloadURL();
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final message = MessageModel(
        toId: reveiverId!,
        msg: imgUrl,
        read: 'false',
        type: Type.image,
        fromId: user.uid,
        sent: time);
    var ref = firestore
        .collection('chats/${getConversatioId(reveiverId!)}/messages/');
    await ref.doc(time).set(message.toJson());
  }
}
