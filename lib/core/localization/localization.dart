import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/localization/generated/localization.dart';

extension Localization on BuildContext {
  L10n get locale {
    return L10n.of(this);
  }
}
