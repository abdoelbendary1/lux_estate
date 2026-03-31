import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

extension PropertyUnitFormatter on PropertyUnitEntity {
  /// السعر بصيغة مختصره (1.2M) للـ Tiles الصغيره
  String get formattedPriceCompact {
    if (price == null) return r"$0";
    return NumberFormat.compactCurrency(
      symbol: r'$',
      decimalDigits: 0,
      locale: 'en', // أو خليه يتبع الـ Locale الحالي
    ).format(price);
  }

  /// السعر بالكامل (1,200,000) لصفحة التفاصيل
  String get formattedPriceFull {
    if (price == null) return r"$0";
    return NumberFormat.currency(symbol: r'$', decimalDigits: 0).format(price);
  }

  /// لو العقار إيجار، بيضيف كلمة /Month مثلاً
  String get priceWithPeriod {
    // افترضنا إن عندك field اسمه isForRent في الـ Entity
    // String period = isForRent ? "/mo" : "";
    return "$formattedPriceFull";
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
