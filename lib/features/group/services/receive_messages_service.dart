import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/main/models/message_model.dart';

class ReceiveMessagesService {
  final UserDataService userDataService = UserDataService.instance;
  Stream<List<MessageModel>> getAllGroupMessages(
    String groupId,
  ) {
    return userDataService.getAllGroupMessages(groupId).map(
          (event) => event.docs
              .map(
                (e) => MessageModel.fromJson(e.data()),
              )
              .toList(),
        );
  }
}
