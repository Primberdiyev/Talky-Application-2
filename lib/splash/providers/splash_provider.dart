import 'dart:developer';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/utils/profile_state.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class SplashProvider extends BaseChangeNotifier {
  final userDataService = UserDataService.instance;
  ProfileState profileState = ProfileState.initial;

  Future<void> getProfileState() async {
    updateState(Statuses.loading);
    final currentDate = DateTime.now();
    try {
      final user = userDataService.auth.currentUser;
      if (user != null) {
        final response = await userDataService.getUserModel();
        profileState = response?.profileState ?? ProfileState.initial;
        _finish(
          status: Statuses.completed,
          date: currentDate,
        );
      } else {
        _finish(
          status: Statuses.error,
          date: currentDate,
        );
      }
    } catch (e) {
      log("error on splash page  ${e.toString()}");
      _finish(
        status: Statuses.error,
        date: currentDate,
      );
    }
  }

  void _finish({
    required Statuses status,
    required DateTime date,
  }) {
    final diffMilliseconds = DateTime.now().difference(date).inMilliseconds;
    if (diffMilliseconds > 5000) {
      updateState(status);
    } else {
      Future.delayed(
        Duration(milliseconds: 5000 - diffMilliseconds),
        () => updateState(status),
      );
    }
  }
}
