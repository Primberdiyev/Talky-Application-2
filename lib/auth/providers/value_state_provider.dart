import 'package:flutter/material.dart';
import 'package:talky_aplication_2/unilities/bool_value_enum.dart';

class ValueStateProvider with ChangeNotifier {
  bool isSignIn = true;
  bool agreeCondition = false;
  bool isHideText = true;
  bool isLoading = false;
  bool isEmailCorrect = true;

  void changeBoolValue(BoolValueEnum value) {
    switch (value) {
      case BoolValueEnum.isSignIn:
        isSignIn = !isSignIn;
        break;
      case BoolValueEnum.agreeCondition:
        agreeCondition = !agreeCondition;
        break;
      case BoolValueEnum.isHideText:
        isHideText = !isHideText;
        break;
      case BoolValueEnum.isLoading:
        isLoading = !isLoading;
        break;
    }

    notifyListeners();
  }

  changeIsMailCorrect(bool newValue) {
    isEmailCorrect = newValue;
    notifyListeners();
  }
}
