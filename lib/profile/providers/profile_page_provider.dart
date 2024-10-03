import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      final dowloadUrl = await snapshot?.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser?.uid)
          .set(
        {
          'name': nameController.text,
          'description': descriptionController.text,
          'imgUrl': dowloadUrl,
        },
        SetOptions(merge: true),
      );
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
          if (imgUrl!.startsWith('gs://')) {
            final ref = FirebaseStorage.instance.refFromURL(imgUrl!);
            imgUrls[imgUrl!] = await ref.getDownloadURL();
          } else {
            imgUrls[imgUrl!] = imgUrl!;
          }
        }
      }
    }

    await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser?.uid)
        .update({
      'isOnline': true,
    });
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
