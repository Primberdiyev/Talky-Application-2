import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talky_aplication_2/auth/models/user_model.dart';
import 'package:talky_aplication_2/base/base_change_notifier.dart';
import 'package:talky_aplication_2/unilities/statuses.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfilePageProvider extends BaseChangeNotifier {
  XFile? image;
  UploadTask? uploadTask;
  // bool isLoading = false;
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

  Future<void> saveUserProfile(
      {required String name, required String? description}) async {
    updateState(Statuses.loading);
    if (currentUser != null && image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('${currentUser?.email}/profile_image.png');
      uploadTask = ref.putFile(File(image!.path));
      final snapshot = await uploadTask?.whenComplete(() {});
      final photoUrl = await snapshot?.ref.getDownloadURL();

      final userInfo = UserModel(
          name: name, description: description ?? '', imgUrl: photoUrl);

      await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser?.uid)
          .update(userInfo.toJson());
      updateState(Statuses.completed);
    }
  }

  // setIsLoading() {
  //   isLoading = !isLoading;
  //   notifyListeners();
  // }

  updateIsNameEmpty(bool newValue) {
    isNameEmpty = newValue;
    notifyListeners();
  }

  FutureOr getUserCollection() async {
    final snapshot = await firestore.collection('User').get();
    usersData =
        snapshot.docs.where((value) => value.id != currentUser?.uid).toList();
    countUsers = usersData!.length;
    filteredUsers = usersData!;
    final querySnapshot = await firestore
        .collection('User')
        .where('email', isEqualTo: currentUser?.email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      currentUserImgUrl = querySnapshot.docs.first['imgUrl'];
    } else {
      currentUserImgUrl = null;
    }

    const userTime = UserModel(isOnline: true);
    await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser?.uid)
        .update(userTime.toJson());

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
