import 'dart:developer';

import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class GroupProvider extends BaseChangeNotifier {
  late List<String> pressedUsers = [];
  List<String> get reallyList => pressedUsers;
  GroupModel? groupModel;
  final UserDataService userDataService = UserDataService.instance;
  Map<String, dynamic> usersImages = {};
  bool isUserPressed(String userId) => pressedUsers.contains(userId);

  void changeUserPressed(String userId) {
    if (pressedUsers.contains(userId)) {
      pressedUsers.remove(userId);
    } else {
      pressedUsers.add(userId);
    }
    notifyListeners();
  }

  Future<void> createGroup({
    required GroupModel model,
    required String adminId,
  }) async {
    updateState(Statuses.loading);
    final userDataService = UserDataService.instance;

    List<String> allUsersId = model.usersId ?? [];
    allUsersId.add(adminId);
    try {
      groupModel = model;
      await userDataService.setGroupModel(
        groupModel: groupModel,
        id: model.id ?? '',
      );
      await userDataService.addMembersGroup(
        allUsersId: allUsersId,
        groupId: model.id ?? "",
      );

      updateState(Statuses.completed);
    } catch (e) {
      updateState(Statuses.error);
      log('error on creating group $e ');
    }
  }

  Future<void>? getUserImg(String id) async {
    if (usersImages.containsKey(id)) {
      return usersImages[id];
    }
    try {
      final response = await UserDataService.instance.getUserDoc(id: id);
      final user = UserModel.fromJson(response.data() ?? {});
      usersImages[user.id ?? ""] = user.imgUrl;
    } catch (e) {
      log('xato ${e.toString()}');
    }
  }
}
