import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUser(String id, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .set(userInfoMap);
  }

  Future<bool> isUserRegistered(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('User').doc(userId).get();
    return doc.exists;
  }
}
