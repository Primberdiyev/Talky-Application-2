import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/unilities/bool_value_enum.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future signInWithGoogle(BuildContext context) async {
    final provider = Provider.of<TalkyProvider>(context, listen: false);
   // provider.updateState(Statuses.loading);
    try {
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
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
          provider.changeEmailPassword(userDetails.email!, userDetails.uid);
          await FirebaseFirestore.instance
              .collection('User')
              .doc(userDetails.uid)
              .set({
            'email': provider.emailController.text,
            'id': userDetails.uid,
          });
          Navigator.pushNamed(context, NameRoutes.accout);
        }
        provider.deleteControllerText();
        provider.updateState(Statuses.completed);
      }
    } catch (error) {
      // print("Error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: $error')),
      );
      provider.updateState(Statuses.error);
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
