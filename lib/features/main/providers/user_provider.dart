import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<UserModel> chattingUsers = [];
  List<String> chattingUsersId = [];
  Future<void> getUserModel() async {
    updateState(Statuses.loading);
    try {
      final response = await userDataService.getUserDoc(
        id: userDataService.auth.currentUser?.uid ?? '',
      );
      userModel = UserModel.fromJson(response.data() ?? {});
      chattingUsersId = userModel?.chattingUsersId ?? [];
      updateState(Statuses.completed);
    } catch (e) {
      updateState(Statuses.error);
      log('ERR: $e');
    }
  }

  Future<void> getChattingUsers() async {
    updateState(Statuses.loading);
    try {
      final response = await userDataService.getUserDoc(
        id: userDataService.auth.currentUser?.uid ?? '',
      );
      final userModel = UserModel.fromJson(response.data() ?? {});
      final chatIds = userModel.chattingUsersId ?? [].toList();
      if (chatIds.isEmpty) {
        updateState(Statuses.completed);
        return;
      }

      for (var i = 0; i < chatIds.length; i++) {
        final snapshot = await userDataService.getUserDoc(id: chatIds[i]);
        final chattingUserModel = UserModel.fromJson(snapshot.data() ?? {});
        chattingUsers.add(chattingUserModel);
      }
      updateState(Statuses.completed);
    } catch (e) {
      log('error on getting chatting users $e');
    }
  }

  Stream getAllGroupsStream() {
    return userDataService.firebaseFirestore
        .collection(ImportantTexts.user)
        .doc(currentUserId)
        .snapshots()
        .asyncMap((userSnapshot) async {
      if (!userSnapshot.exists) {
        return [];
      }
      final userGroupsId =
          UserModel.fromJson(userSnapshot.data() ?? {}).groupsId;

      if (userGroupsId == null || userGroupsId.isEmpty) {
        return [];
      }
      List<GroupModel> groups = [];
      for (String id in userGroupsId) {
        final groupSnapshot = await userDataService.firebaseFirestore
            .collection(ImportantTexts.groups)
            .doc(id)
            .get();
        if (groupSnapshot.exists) {
          groups.add(GroupModel.fromJson(groupSnapshot.data() ?? {}));
        }
      }
      return groups;
    });
  }

  void addgroup(GroupModel groupModel) {
    allGroups?.add(groupModel);
    notifyListeners();
  }

  void addUserChatting(UserModel userModel) {
    if (!chattingUsers.contains(userModel)) {}
    notifyListeners();
  }

  Future<void> addChattingUser(UserModel newUser) async {
    updateState(Statuses.loading);
    try {
      addUserChatting(newUser);
      await userDataService.setChattingDoc(
        id: currentUserId ?? "",
        data: newUser.id ?? '',
        options: SetOptions(
          merge: true,
        ),
      );
      await userDataService.setChattingDoc(
        id: newUser.id ?? "",
        data: currentUserId ?? '',
        options: SetOptions(
          merge: true,
        ),
      );
      updateState(Statuses.completed);
    } catch (e) {
      updateState(Statuses.error);
      log('error on adding chatting user $e');
    }
  }
}
