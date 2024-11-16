import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class GroupProvider extends BaseChangeNotifier {
  late List<String> pressedUsers = [];
  List<String> get reallyList => pressedUsers;

  bool isUserPressed(String userId) => (pressedUsers).contains(userId);

  void changeUserPressed(String userId) {
    if ((pressedUsers).contains(userId)) {
      pressedUsers.remove(userId);
      print('olindi: $pressedUsers');
    } else {
      pressedUsers.add(userId);
      print('qoshildi: $pressedUsers');
    }
    notifyListeners();
  }

  Future<void> createGroup(GroupModel model) async {
    updateState(Statuses.loading);
    final userDataService = UserDataService.instance;

    try {
      await userDataService.firebaseFirestore
          .collection('groups')
          .doc(model.title)
          .set(
            model.toJson(),
          );
      updateState(Statuses.completed);
    } catch (e) {
      updateState(Statuses.error);
      log('error on creating group $e ');
    }
  }
}
