import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension LocaleData on BuildContext {
  // Helper to pick the right string based on current locale
  String pick(String? ar, String? en) {
    return locale.languageCode == 'ar' ? (ar ?? '') : (en ?? '');
  }
}
