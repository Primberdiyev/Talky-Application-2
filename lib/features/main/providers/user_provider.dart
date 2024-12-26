import 'dart:developer';

import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class UserProvider extends BaseChangeNotifier {
  final userDataService = UserDataService.instance;
  UserModel? userModel;
  final currentUserId = UserDataService.instance.auth.currentUser?.uid;
  List<GroupModel>? allGroups;
  Future<void> getUserModel() async {
    updateState(Statuses.loading);
    try {
      final response = await userDataService.getUserDoc(
        id: userDataService.auth.currentUser?.uid ?? '',
      );
      userModel = UserModel.fromJson(response.data() ?? {});
      updateState(Statuses.completed);
    } catch (e) {
      updateState(Statuses.error);
      log('ERR: $e');
    }
  }

  Stream<List<UserModel>>? getChattingUsers() async* {
    final response = await userDataService.getUserDoc(
      id: userDataService.auth.currentUser?.uid ?? '',
    );
    final userModel = UserModel.fromJson(response.data() ?? {});
    final chatIds = userModel.chattingUsersId ?? [].toList();
    if (chatIds.isEmpty) {
      yield [];
      return;
    }
    List<UserModel> chattingUsers = [];

    for (var i = 0; i < chatIds.length; i++) {
      final snapshot = await userDataService.getUserDoc(id: chatIds[i]);
      final chattingUserModel = UserModel.fromJson(snapshot.data() ?? {});
      chattingUsers.add(chattingUserModel);
    }
    yield chattingUsers;
  }

  Future getAllGroups() async {
    final response = await userDataService.firebaseFirestore
        .collection(ImportantTexts.user)
        .doc(currentUserId)
        .get();

    List<String>? allGroupsId =
        UserModel.fromJson(response.data() ?? {}).groupsId;
    List<GroupModel> groups = [];
    for (String id in allGroupsId ?? []) {
      final groupsSnapshot = await userDataService.firebaseFirestore
          .collection(ImportantTexts.groups)
          .doc(id)
          .get();
      if (groupsSnapshot.exists) {
        final data = groupsSnapshot.data();
        if (data != null) {
          groups.add(GroupModel.fromJson(data));
        }
      }
    }
    allGroups = groups;
    notifyListeners();
  }

  void addgroup(GroupModel groupModel) {
    allGroups?.add(groupModel);
    notifyListeners();
  }
}
