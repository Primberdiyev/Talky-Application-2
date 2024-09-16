import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPageProvider with ChangeNotifier {
  XFile? image;
  UploadTask? uploadTask;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  bool isNameEmpty = false;

  updateImage(newImage) {
    image = newImage;
    notifyListeners();
  }

  FutureOr<void> saveUserProfile() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser != null && image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('${currentuser.email}/profile_image.png');
      uploadTask = ref.putFile(File(image!.path));
      final snapshot = await uploadTask?.whenComplete(() => null);
      final dowloadUrl = await snapshot?.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('User')
          .doc(currentuser.uid)
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
}
