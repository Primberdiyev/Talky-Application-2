import 'package:flutter/material.dart';
import 'package:talky_aplication_2/utils/bool_value_enum.dart';

class ValueStateProvider with ChangeNotifier {
  bool isSignIn = true;
  bool agreeCondition = false;
  bool isHideText = true;

  bool isEmailCorrect = true;

  void changeBoolValue(BoolValueEnum value) {
    switch (value) {
      case BoolValueEnum.isSignIn:
        isSignIn = !isSignIn;
      case BoolValueEnum.agreeCondition:
        agreeCondition = !agreeCondition;
      case BoolValueEnum.isHideText:
        isHideText = !isHideText;
    }

    notifyListeners();
  }

  void changeIsMailCorrect(bool newValue) {
    isEmailCorrect = newValue;
    notifyListeners();
  }
}
