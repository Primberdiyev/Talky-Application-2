import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class UserProvider extends BaseChangeNotifier {
  final userDataService = UserDataService.instance;
  UserModel? userModel;
  List? usersData = [];
  Set<UserModel>? chattingUsers = {};

  Future<void> getUserModel() async {
    updateState(Statuses.loading);
    try {
      final response = await userDataService.getUserDoc(
          id: userDataService.auth.currentUser?.uid ?? '');
      userModel = UserModel.fromJson(response.data() ?? {});

      updateState(Statuses.completed);
    } catch (e) {
      updateState(Statuses.error);
      print('ERR: ${e.toString()}');
    }
  }

  Stream<Set<UserModel>>? getChattingUsers() async* {
    final response = await userDataService.getUserDoc(
        id: userDataService.auth.currentUser?.uid ?? '');
    final userModel = UserModel.fromJson(response.data() ?? {});
    List chatIds = userModel.chattingUsersId ?? [].toList();
    chattingUsers = {};

    for (int i = 0; i < chatIds.length; i++) {
      final snapshot = await userDataService.getUserDoc(id: chatIds[i]);
      UserModel chattingUserModel = UserModel.fromJson(snapshot.data() ?? {});
      chattingUsers?.add(chattingUserModel);
    }
    yield chattingUsers ?? {};
  }
}
