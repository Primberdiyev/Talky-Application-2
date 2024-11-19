import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';

class ReceiveMessagesProvider extends BaseChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllGroupMessages(
      String titliGroup) {
    return firestore.collection('groups/$titliGroup/messages/').snapshots();
  }
}
