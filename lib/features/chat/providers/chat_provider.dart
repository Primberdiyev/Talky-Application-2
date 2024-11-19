import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/profile/models/message_model.dart';
import 'package:uuid/uuid.dart';

class ChatProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  User get user => auth.currentUser!;
  String? lastMessage;

  File? imageFile;

  UserModel? receiverUser;
  bool isUserPressed = false;

  String getConversatioId(String id) {
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
    final sentTime = DateTime.now();
    final idSnapshot = await firestore
        .collection('User')
        .doc(auth.currentUser?.uid)
        .collection('ChattingUsersId')
        .get();
    final chattingUsersId = idSnapshot.docs.map((e) => e.id).toList();
    if (!chattingUsersId.contains(receiverId)) {
      chattingUsersId.add(receiverId);
      final message = UserModel(chattingUsersId: chattingUsersId);
      firestore
          .collection('User')
          .doc(auth.currentUser?.uid)
          .set(message.toJson(), SetOptions(merge: true));
      notifyListeners();
    }
    final message = MessageModel(
      toId: receiverId,
      msg: msg,
      read: 'false',
      type: TypeMessage.text,
      fromId: user.uid,
      sent: time,
      sentTime: sentTime.toString(),
    );

    final ref =
        firestore.collection('chats/${getConversatioId(receiverId)}/messages/');
    try {
      await ref.doc(time).set(message.toJson());
    } catch (_) {
      throw Exception();
    }
  }

  changeReceiverUser(newUser) {
    receiverUser = newUser;
    notifyListeners();
  }

  Future getImage() async {
    final picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    final imageName = const Uuid().v1();
    final refStorage =
        storage.ref().child('chatImages').child('$imageName.png');
    final uploadTask = await refStorage.putFile(imageFile!);
    final imgUrl = await uploadTask.ref.getDownloadURL();
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final sentTime = DateTime.now().hour;

    final message = MessageModel(
      toId: receiverUser!.id!,
      msg: imgUrl,
      read: 'false',
      type: TypeMessage.image,
      fromId: user.uid,
      sent: time,
      sentTime: sentTime.toString(),
    );
    final ref = firestore.collection(
      'chats/${getConversatioId(receiverUser!.id ?? '')}/messages/',
    );
    await ref.doc(time).set(message.toJson());
  }

  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'mp3'],
    );
    if (result != null) {
      TypeMessage type;
      if (result.files.single.extension == 'mp3') {
        type = TypeMessage.audio;
      } else {
        type = TypeMessage.file;
      }
      final file = File(result.files.single.path!);
      final fileName = result.files.single.name;
      final refStorage = storage.ref().child('chatFiles').child(fileName);
      final uploadTask = await refStorage.putFile(file);
      final fileUrl = await uploadTask.ref.getDownloadURL();
      final time = DateTime.now().microsecondsSinceEpoch.toString();
      final sentTime = DateTime.now().hour;

      final message = MessageModel(
        toId: receiverUser?.id ?? '',
        msg: fileUrl,
        read: 'false',
        type: type,
        fromId: user.uid,
        sent: time,
        sentTime: sentTime.toString(),
      );

      final ref = firestore.collection(
        'chats/${getConversatioId(receiverUser?.id ?? '')}/messages/',
      );
      await ref.doc(time).set(message.toJson());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getImages(String receiverId) {
    return firestore
        .collection('chats/${getConversatioId(receiverId)}/messages')
        .where('type', isEqualTo: 'image')
        .snapshots();
  }

  Stream<Map<String, String>> getLastMessageWithTime(String id) {
    return firestore
        .collection('chats/${getConversatioId(id)}/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        return {'msg': data['msg'] ?? '', 'sentTime': data['sentTime'] ?? ''};
      } else {
        return {'msg': '', 'sentTime': ''};
      }
    });
  }

  changeUserPressed() {
    isUserPressed = !isUserPressed;
    notifyListeners();
  }
}
