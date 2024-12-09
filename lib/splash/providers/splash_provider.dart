import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/utils/profile_state.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class SplashProvider extends BaseChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  ProfileState profileState = ProfileState.initial;

  Future<void> getProfileState() async {
    updateState(Statuses.loading);
    final currentDate = DateTime.now();
    try {
      final user = auth.currentUser;
      if (user != null) {
        final doc = firebaseStore.collection('User').doc(user.uid);
        final json = await doc.get();
        profileState = UserModel.fromJson(
              json.data() ?? {},
            ).profileState ??
            ProfileState.initial;
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
