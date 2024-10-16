import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talky_aplication_2/profile/models/set_profile_model.dart';
import 'package:talky_aplication_2/profile/models/user_time_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfilePageProvider with ChangeNotifier {
  XFile? image;
  UploadTask? uploadTask;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  bool isNameEmpty = false;
  List? usersData;
  int? countUsers;
  var currentUser = FirebaseAuth.instance.currentUser;
  String? imgUrl;
  Map<String, String> imgUrls = {};
  List filteredUsers = [];

  updateImage(newImage) {
    image = newImage;
    notifyListeners();
  }

  FutureOr<void> saveUserProfile() async {
    if (currentUser != null && image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('${currentUser?.email}/profile_image.png');
      uploadTask = ref.putFile(File(image!.path));
      final snapshot = await uploadTask?.whenComplete(() {});
      final dowloadImgUrl = await snapshot?.ref.getDownloadURL();

      final userInfo = SetProfileModel(
          name: nameController.text,
          description: descriptionController.text,
          imgUrl: dowloadImgUrl!);

      await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser?.uid)
          .update(userInfo.toJson());
    }
  }

  setIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  updateIsNameEmpty(bool newValue) {
    isNameEmpty = newValue;
    notifyListeners();
  }

  FutureOr getUserCollection() async {
    final snapshot = await FirebaseFirestore.instance.collection('User').get();
    usersData = snapshot.docs;
    countUsers = usersData!.length;
    if (usersData != null) {
      for (var user in usersData!) {
        imgUrl = user['imgUrl'];
        if (imgUrl != null) {
          if (user.id == currentUser?.uid) {
            imgUrls['currentUserImgUrl'] = user['imgUrl'];
          }

          imgUrls[imgUrl!] = imgUrl!;
        }
      }
    }
    final userTime = UserTimeModel(isOnline: true);
    await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser?.uid)
        .set(userTime.toJson(), SetOptions(merge: true));

    usersData =
        usersData!.where((value) => value.id != currentUser?.uid).toList();
    countUsers = usersData!.length;
    filteredUsers = usersData!;

    notifyListeners();
  }

  String timeAgo(dynamic timestamp) {
    DateTime dateTime;
    if (timestamp is Timestamp) {
      dateTime = timestamp.toDate();
    } else if (timestamp is DateTime) {
      dateTime = timestamp;
    } else {
      return 'incorrect time';
    }
    return timeago.format(dateTime);
  }

  updateCurrentUser(newUser) {
    currentUser = newUser;
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
}
