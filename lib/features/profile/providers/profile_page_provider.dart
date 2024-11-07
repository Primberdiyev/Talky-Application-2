import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/unilities/profile_state.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';

class ProfilePageProvider extends BaseChangeNotifier {
  XFile? image;
  UploadTask? uploadTask;
  bool isNameEmpty = false;
  List? usersData;
  int? countUsers;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? currentUserImgUrl;
  final firestore = FirebaseFirestore.instance;
  List filteredUsers = [];

  updateImage(newImage) {
    image = newImage;
    notifyListeners();
  }

  loadGoogleProfile() {
    if (currentUser != null) {
      currentUserImgUrl = currentUser?.photoURL;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future<void> saveUserProfile(
      {required String name, required String? description}) async {
    updateState(Statuses.loading);

    String? photoUrl = currentUserImgUrl;

    if (image != null) {
      final ref = FirebaseStorage.instance.ref().child(
          '${FirebaseAuth.instance.currentUser?.email}/profile_image.png');
      uploadTask = ref.putFile(File(image!.path));
      final snapshot = await uploadTask?.whenComplete(() {});
      photoUrl = await snapshot?.ref.getDownloadURL();
    }

    final userInfo = UserModel(
        name: name,
        description: description ?? '',
        imgUrl: photoUrl,
        profileState: ProfileState.completed);

    await UserDataService.instance.setUserDoc(
      userInfo.toJson(),
    );

    updateState(Statuses.completed);
  }

  updateIsNameEmpty(bool newValue) {
    isNameEmpty = newValue;
    notifyListeners();
  }

  onSearchChanged(String enteredUser) {
    if (enteredUser.isEmpty) {
      filteredUsers = usersData!;
    } else {
      filteredUsers = usersData!
          .where((user) =>
              user['name'].toLowerCase().contains(enteredUser.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  changeCurrentUser(User? newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
