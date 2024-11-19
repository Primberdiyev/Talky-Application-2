import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/unilities/profile_state.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class AuthGoogleProvider extends BaseChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  ProfileState profileState = ProfileState.initial;
  final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

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
        await auth.signInWithCredential(cred);
        final user = auth.currentUser;
        if (user != null) {
          final doc = firebaseStore.collection('User').doc(user.uid);
          final json = await doc.get();

          if (json.exists && json.data() != null) {
            profileState = UserModel.fromJson(
                  json.data() ?? {},
                ).profileState ??
                ProfileState.initial;
          } else {
            print('userModel failded');
          }
          if (profileState == ProfileState.initial) {
            await doc.set(
              UserModel(
                email: user.email,
                id: user.uid,
                profileState: ProfileState.create,
              ).toJson(),
            );
            profileState = ProfileState.create;
          }
          updateState(Statuses.completed);
          return user;
        } else {
          print('tushdi');
          updateState(Statuses.error);
        }
      } else {
        updateState(Statuses.initial);
      }
    } catch (e) {
      updateState(Statuses.error);
      print('Google Sign-In failed: $e');
    }
    return null;
  }
}
