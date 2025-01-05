import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/group/models/group_message_model.dart';

class ReceiveMessagesService {
  final UserDataService userDataService = UserDataService.instance;
  Stream<List<GroupMessageModel>> getAllGroupMessages(
    String groupId,
  ) {
    return userDataService.getAllGroupMessages(groupId).map(
          (event) => event.docs
              .map(
                (e) => GroupMessageModel.fromJson(e.data()),
              )
              .toList(),
        );
  }
}
