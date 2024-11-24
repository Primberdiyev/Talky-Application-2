import 'dart:developer';

import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class GroupProvider extends BaseChangeNotifier {
  late List<String> pressedUsers = [];
  List<String> get reallyList => pressedUsers;
  GroupModel? groupModel;

  bool isUserPressed(String userId) => pressedUsers.contains(userId);

  void changeUserPressed(String userId) {
    if (pressedUsers.contains(userId)) {
      pressedUsers.remove(userId);
    } else {
      pressedUsers.add(userId);
    }
    notifyListeners();
  }

  Future<void> createGroup() async {
    updateState(Statuses.loading);
    final userDataService = UserDataService.instance;

    try {
      await userDataService.firebaseFirestore
          .collection('groups')
          .doc(groupModel?.title)
          .set(
            groupModel?.toJson() ?? {},
          );
      updateState(Statuses.completed);
    } catch (e) {
      updateState(Statuses.error);
      log('error on creating group $e ');
    }
  }

  void getGroupModel(GroupModel newGroupModel) {
    groupModel = newGroupModel;
    notifyListeners();
  }
}
