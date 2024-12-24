import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';

class ReceiveMessagesService {
  final UserDataService userDataService = UserDataService.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllGroupMessages(
    String titliGroup,
  ) {
    return userDataService.getAllGroupMessages(titliGroup);
  }
}
