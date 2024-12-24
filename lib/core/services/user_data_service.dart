import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';

class UserDataService {
  UserDataService._();
  static final UserDataService _instance = UserDataService._();
  static UserDataService get instance => _instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<UserModel?> getUserModel() async {
    final response = await firebaseFirestore
        .collection(ImportantTexts.user)
        .doc(
          auth.currentUser?.uid,
        )
        .get();

    return UserModel.fromJson(
      response.data() ?? {},
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDoc({
    required String id,
  }) {
    return firebaseFirestore.collection(ImportantTexts.user).doc(id).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsersDoc() {
    return firebaseFirestore.collection(ImportantTexts.user).get();
  }

  Future<void> setUserDoc(
    Map<String, dynamic> data, [
    SetOptions? options,
  ]) {
    return firebaseFirestore
        .collection(ImportantTexts.user)
        .doc(
          auth.currentUser?.uid,
        )
        .set(data, options);
  }

  Future<void> setChattingDoc({
    required String data,
    required String id,
    SetOptions? options,
  }) {
    return firebaseFirestore.collection(ImportantTexts.user).doc(id).set(
      {
        ImportantTexts.chattingId: FieldValue.arrayUnion([data]),
      },
      options,
    );
  }

  Future<void> setUpdateLastTime() async {
    try {
      await firebaseFirestore
          .collection(ImportantTexts.user)
          .doc(
            auth.currentUser?.uid,
          )
          .update(
        {
          ImportantTexts.lasTime: DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      log(" error on updating last time ${e.toString()}");
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getChatUsersId() {
    return firebaseFirestore
        .collection(ImportantTexts.user)
        .doc(auth.currentUser?.uid)
        .collection(ImportantTexts.chats)
        .get();
  }

  FutureOr<bool> isRegistered(String email) async {
    final userDoc = await firebaseFirestore
        .collection(ImportantTexts.user)
        .where('email', isEqualTo: email)
        .get();
    return userDoc.docs.isNotEmpty;
  }

  Future sendMessageGroup({
    required String groupTitle,
    required String time,
    required MessageModel message,
  }) async {
    final ref = firebaseFirestore.collection('groups/$groupTitle/messages/');
    return await ref.doc(time).set(message.toJson());
  }

  Future setGroupModel({
    required GroupModel? groupModel,
    required String id,
  }) async {
    await firebaseFirestore
        .collection(ImportantTexts.groups)
        .doc(id)
        .set(groupModel?.toJson() ?? {});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllGroupMessages(
    String titliGroup,
  ) {
    return firebaseFirestore
        .collection('groups/$titliGroup/messages')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(String chatId) {
    return firebaseFirestore.collection('chats/$chatId/messages/').snapshots();
  }

  Future sendMessage({
    required chatId,
    required String time,
    required MessageModel messageModel,
  }) async {
    final ref = firebaseFirestore.collection('chats/$chatId/messages/');
    await ref.doc(time).set(messageModel.toJson());
  }

  CollectionReference<Map<String, dynamic>> getChatMessagesRef(String chatId) {
    return firebaseFirestore.collection('chats/$chatId/messages');
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllImages(String chatId) {
    return getChatMessagesRef(chatId).where('type', isEqualTo: 'image').get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessageStream(
    String chatId,
  ) {
    return getChatMessagesRef(chatId)
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  Future addMembersGroup({
    required List<String> allUsersId,
    required String groupId,
  }) async {
    for (String id in allUsersId) {
      await firebaseFirestore.collection(ImportantTexts.user).doc(id).set(
        {
          'groupsId': FieldValue.arrayUnion(
            [groupId],
          ),
        },
        SetOptions(merge: true),
      );
    }
  }
}
