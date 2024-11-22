import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';

class UserDataService {
  UserDataService._();
  static final UserDataService _instance = UserDataService._();
  static UserDataService get instance => _instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserModel() async {
    final response = await firebaseFirestore
        .collection('User')
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
    return firebaseFirestore.collection('User').doc(id).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsersDoc() {
    return firebaseFirestore.collection('User').get();
  }

  Future<void> setUserDoc(
    Map<String, dynamic> data, [
    SetOptions? options,
  ]) {
    return firebaseFirestore
        .collection('User')
        .doc(
          auth.currentUser?.uid,
        )
        .set(data, options);
  }

  Future<void> setUpdateLastTime() async {
    try {
      await firebaseFirestore
          .collection('User')
          .doc(
            auth.currentUser?.uid,
          )
          .update(
        {
          'lasTime': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      log(" error on updating last time ${e.toString()}");
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getChatUsersId() {
    return firebaseFirestore
        .collection('User')
        .doc(auth.currentUser?.uid)
        .collection('ChattingUsersId')
        .get();
  }
}
