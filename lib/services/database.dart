import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUser(String id, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .set(userInfoMap);
  }

  Future<bool> isUserRegistered(String id) async {
    final doc =
        await FirebaseFirestore.instance.collection('User').doc(id).get();
    return doc.exists;
  }
}
