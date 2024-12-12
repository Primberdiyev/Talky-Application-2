import 'dart:developer';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';

class GroupProvider extends BaseChangeNotifier {
  final UserDataService userDataService = UserDataService.instance;
  Future sendMessageGroup({
    required String msg,
    required String groupTitle,
  }) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final message = MessageModel(
      toId: '',
      msg: msg,
      read: 'false',
      type: TypeMessage.text,
      fromId: userDataService.auth.currentUser?.uid ?? '',
      sent: time,
      sentTime: DateTime.now().toString(),
    );
    final ref = userDataService.firebaseFirestore
        .collection('groups/$groupTitle/messages/');
    try {
      await ref.doc(time).set(message.toJson());
    } catch (e) {
      log('error sending message to goup $e');
    }
  }
}
