
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talky_aplication_2/auth/models/user_model.dart';
import 'package:talky_aplication_2/base/base_change_notifier.dart';
import 'package:talky_aplication_2/unilities/profile_state.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class AuthGoogleProvider extends BaseChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  ProfileState profileState = ProfileState.initial;
  final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  Future<void> signInGoogle() async {
    updateState(Statuses.loading);
    try {
      final gSignIn = GoogleSignIn();
      if (await gSignIn.isSignedIn()) {
        await gSignIn.signOut();
      }
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final cred = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        await auth.signInWithCredential(cred);
        final user = auth.currentUser;
        if (user != null) {
          final doc = firebaseStore.collection('User').doc(user.uid);
          final json = await doc.get();
          try {
            profileState = UserModel.fromJson(
                  json.data() ?? {},
                ).profileState ??
                ProfileState.initial;
          } catch (e) {
            print("UserModel failed: $e");
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
        } else {
          updateState(Statuses.error);
        }
      } else {
        updateState(Statuses.initial);
      }
    } catch (e) {
      updateState(Statuses.error);
      print("Google Sign-In failed: $e");
    }
  }
}
