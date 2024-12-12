import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
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
}
