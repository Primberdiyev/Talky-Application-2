import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/models/user_model.dart';
import 'package:talky_aplication_2/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/base/base_change_notifier.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class AuthGoogleProvider extends BaseChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    updateState(Statuses.loading);
    try {
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        updateState(Statuses.completed);
        return;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? userDetails = result.user;
      final profileProvider =
          Provider.of<ProfilePageProvider>(context, listen: false);

      profileProvider.updateCurrentUser(userDetails);

      if (userDetails != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('User')
            .doc(userDetails.uid)
            .get();

        if (doc.exists) {
          Navigator.pushNamed(context, NameRoutes.profile);
        } else {
          final user = UserModel(email: userDetails.email, id: userDetails.uid);
          await FirebaseFirestore.instance
              .collection('User')
              .doc(userDetails.uid)
              .set(user.toJson(), SetOptions(merge: true));
          Navigator.pushNamed(context, NameRoutes.accout);
        }
        final signProvider =
            Provider.of<SignInAndUpProvider>(context, listen: false);
        signProvider.deleteControllerText();
        updateState(Statuses.completed);
      }
    } catch (error) {
      updateState(Statuses.error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: $error')),
      );
    }
  }

  Future<void> sendPasswordresetLink(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception();
    }
  }
}
