import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

enum PropertyCategories {
  villa(id: '1', key: LocaleKeys.villa),
  apartment(id: '2', key: LocaleKeys.apartment),
  houses(id: '3', key: LocaleKeys.houses),
  office(id: '4', key: LocaleKeys.office),
  shop(id: '5', key: LocaleKeys.shop),
  garage(id: '6', key: LocaleKeys.garage),
  studio(id: '7', key: LocaleKeys.studio),
  all(id: '8', key: LocaleKeys.all);

  final String id;
  final String key; // تخزين الـ Key المولد من الـ Generator

  const PropertyCategories({required this.id, required this.key});

  // بدل ما تجيب الاسم هنا، هنستخدم extension في الـ UI أو نبعت الـ context
  String getLocalizedName(BuildContext context) {
    return key.tr();
  }
}
