import 'dart:developer';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/group/models/group_message_model.dart';
import 'package:talky_aplication_2/routes/message_types.dart';

class GroupChatProvider extends BaseChangeNotifier {
  final UserDataService userDataService = UserDataService.instance;
  Future sendMessageGroup({
    required String msg,
    required String id,
    required UserModel? userModel,
  }) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final message = GroupMessageModel(
      id: userModel?.id ?? '',
      dateTime: DateTime.now(),
      message: msg,
      type: MessageTypes.text,
      userModel: userModel,
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
