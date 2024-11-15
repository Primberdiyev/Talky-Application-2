import 'package:flutter/material.dart';

class GroupProvider with ChangeNotifier {
  final Set<String> _pressedUsers = {};

  bool isUserPressed(String userId) => _pressedUsers.contains(userId);

  void changeUserPressed(String userId) {
    if (_pressedUsers.contains(userId)) {
      _pressedUsers.remove(userId);
    } else {
      _pressedUsers.add(userId);
    }
    notifyListeners();
  }
}
