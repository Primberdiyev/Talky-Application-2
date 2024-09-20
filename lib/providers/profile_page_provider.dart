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
  final currentUser = FirebaseAuth.instance.currentUser;

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
      final snapshot = await uploadTask?.whenComplete(() => null);
      final dowloadUrl = await snapshot?.ref.getDownloadURL();
      final DateTime now = DateTime.now();

      await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser?.uid)
          .set(
        {
          'name': nameController.text,
          'description': descriptionController.text,
          'imgUrl': dowloadUrl,
          'closingTime': now,
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
    countUsers = snapshot.size;

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
}
