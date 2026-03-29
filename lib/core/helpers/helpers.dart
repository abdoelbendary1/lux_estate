import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

int convertFromSqFtToSqMeters(double sqFt) {
  double sqMeters = sqFt * 0.0929;
  return sqMeters.toInt();
}

String formatPrice(PropertyUnitEntity propertyUnit) {
  String formattedPrice = NumberFormat('#,###').format(propertyUnit.price ?? 0);

  return formattedPrice;
}

Color getListColor(String id) {
  try {
    PropertyCategories category = PropertyCategories.values.firstWhere(
      (element) => element.id == id,
    );
    switch (category) {
      case PropertyCategories.all:
        return AppColors.accentBlue;
        break;
      case PropertyCategories.apartment:
        return AppColors.error;
        break;
      case PropertyCategories.houses:
        return AppColors.greenTagBg;
        break;
      case PropertyCategories.villa:
        return AppColors.success;

        break;
      case PropertyCategories.office:
        return AppColors.grey;

        break;
      case PropertyCategories.shop:
        return AppColors.warning;

        break;
      case PropertyCategories.garage:
        return AppColors.info;

        break;
      case PropertyCategories.studio:
        return AppColors.warning;

        break;
    }
  } catch (e) {
    return AppColors.primary;
  }
}
