import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/services/database.dart';

class AuthGoogle {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final talkyProvider = Provider.of<TalkyProvider>(context, listen: false);

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? userDetails = result.user;

      if (userDetails != null) {
        Map<String, dynamic> userInfoMap = {
          'email': userDetails.email,
          'name': userDetails.displayName,
          'imgUrl': userDetails.photoURL,
          'id': userDetails.uid,
        };

        talkyProvider.changeEmailPassword(
            userDetails.email!, userDetails.displayName!);

        bool isRegistered =
            await DatabaseMethods().isUserRegistered(userDetails.uid);

        if (isRegistered) {
          Navigator.pushNamed(context, '/AccountPage');
          talkyProvider.deleteControllerText();
        } else {
          try {
            await DatabaseMethods().addUser(userDetails.uid, userInfoMap);
            talkyProvider.sendOTP(email: userDetails.email!);
            Navigator.pushNamed(context, '/checkCodePage');
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error adding user: $error')),
            );
          }
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: $error')),
      );
    }
  }
}
