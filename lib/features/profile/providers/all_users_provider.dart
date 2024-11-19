import 'dart:async';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';

class AllUsersProvider with ChangeNotifier {
  UserDataService userDataService = UserDataService.instance;
  List<UserModel> allUsers = [];

  Future<void> getAllUsers() async {
    try {
      final response = await userDataService.getAllUsersDoc();
      allUsers = response.docs
          .where((user) => userDataService.auth.currentUser?.uid != user.id)
          .map((user) => UserModel.fromJson(user.data()))
          .toList();

      allUsers.sort((a, b) {
        final nameA = a.name ?? '';
        final nameB = b.name ?? '';
        return nameA.compareTo(nameB);
      });
    } catch (e) {
      print('Failed getting all users data');
    }
    notifyListeners();
  }
}
