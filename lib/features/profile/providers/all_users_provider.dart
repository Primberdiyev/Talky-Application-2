import 'dart:async';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';

class AllUsersProvider with ChangeNotifier {
  UserDataService userDataService = UserDataService.instance;
  List? allUsers;

  FutureOr getAllUsers() async {
    try {
      final response = await userDataService.getAllUsersDoc();
      allUsers = response.docs
          .where((user) => userDataService.auth.currentUser?.uid != user.id)
          .toList();

      allUsers?.sort((a, b) {
        return a['name'].compareTo(b['name']);
      });
    } catch (e) {
      print('Failed getting all users data');
    }
    notifyListeners();
  }
}
