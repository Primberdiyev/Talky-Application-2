import 'dart:developer';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';

class GroupChatProvider extends BaseChangeNotifier {
  final UserDataService userDataService = UserDataService.instance;
  Future sendMessageGroup({
    required String msg,
    required String id,
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

    try {
      await userDataService.sendMessageGroup(
        time: time,
        message: message,
        id: id,
      );
    } catch (e) {
      log('error sending message to goup $e');
    }
  }
}
