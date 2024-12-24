import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/utils/profile_state.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class AuthGoogleProvider extends BaseChangeNotifier {
  ProfileState profileState = ProfileState.initial;
  final userDataService = UserDataService.instance;

  Future<User?> signInGoogle() async {
    updateState(Statuses.loading);
    try {
      final gSignIn = GoogleSignIn();
      if (await gSignIn.isSignedIn()) {
        await gSignIn.signOut();
      }
      final gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final gAuth = await gUser.authentication;
        final cred = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        await userDataService.auth.signInWithCredential(cred);
        final user = userDataService.auth.currentUser;
        if (user != null) {
          final UserModel? doc = await userDataService.getUserModel();
          if (doc != null) {
            profileState = doc.profileState ?? ProfileState.initial;
          }
          if (profileState == ProfileState.initial) {
            final userModel = UserModel(
              email: user.email,
              id: user.uid,
              profileState: ProfileState.create,
            );
            await UserDataService.instance.setUserDoc(userModel.toJson());

            profileState = ProfileState.create;
          }
          updateState(Statuses.completed);
          return user;
        } else {
          updateState(Statuses.error);
        }
      } else {
        updateState(Statuses.initial);
      }
    } catch (e) {
      updateState(Statuses.error);
      log('Google Sign-In failed: $e');
    }
    return null;
  }
}
