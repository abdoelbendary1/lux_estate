import 'package:easy_localization/easy_localization.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

import 'package:flutter/material.dart';

extension PropertyUnitFormatter on PropertyUnitEntity {
  /// السعر بصيغة مختصره (1.2M)
  String formattedPriceCompact(BuildContext context) {
    if (price == null) return r"$0";

    return NumberFormat.compactCurrency(
      symbol: "",
      decimalDigits: 0,
      locale: context.locale.languageCode, // هيستخدم لغة الجهاز/التطبيق الحالية
    ).format(price);
  }

  /// السعر بالكامل (1,200,000)
  String formattedPriceFull(BuildContext context) {
    if (price == null) return r"$0";

    return NumberFormat.currency(
      // symbol: r'',
      decimalDigits: 0,
      locale: context.locale.languageCode,
    ).format(price);
  }

  /// السعر مع الفترة (للحالات اللي فيها إيجار مثلاً)
  String priceWithPeriod(BuildContext context, {bool isForRent = false}) {
    final priceStr = formattedPriceFull(context);

    if (isForRent) {
      // هنا بيجيب الترجمة من ملفات الـ JSON عندك
      // سواء "/mo" أو "/شهر"
      return "$priceStr ${"price_period".tr()}";
    }

    return priceStr;
  }
}

extension DisplayUnitSize on PropertyUnitEntity {
  String get formattedSize {
    // size is in square meters, we want to format it as "120 m²"
    // format into meters with no decimals, and add "m²" at the end

    if (size == null) return "0 m²";

    return "${size!.toStringAsFixed(0)} m²";
  }
}
