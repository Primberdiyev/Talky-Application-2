import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class UserProvider extends BaseChangeNotifier {
  final userDataService = UserDataService.instance;
  UserModel? userModel;

  List? usersData = [];

  Future<void> getUserModel() async {
    updateState(Statuses.loading);
    try {
      final response = await userDataService.getUserDoc();
      userModel = UserModel.fromJson(response.data() ?? {});

      updateState(Statuses.completed);
    } catch (e) {
      updateState(Statuses.error);
      print('ERR: ${e.toString()}');
    }
  }
}
