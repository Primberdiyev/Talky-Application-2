import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';

class UserDataService {
  static final UserDataService _instance = UserDataService._();
  static UserDataService get instance => _instance;
  UserDataService._();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserModel() async {
    final response = await firebaseFirestore
        .collection("User")
        .doc(
          auth.currentUser?.uid,
        )
        .get();
    return UserModel.fromJson(response.data() ?? {});
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDoc(
      {required String id}) async {
    return firebaseFirestore.collection('User').doc(id).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsersDoc() async {
    return firebaseFirestore.collection('User').get();
  }

  Future<void> setUserDoc(Map<String, dynamic> data,
      [SetOptions? options]) async {
    return firebaseFirestore
        .collection("User")
        .doc(
          auth.currentUser?.uid,
        )
        .update(data);
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
      log(e.toString());
    }
  }
}
