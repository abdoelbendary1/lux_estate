import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/extentions/unit_formatter.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class PropertyStatsRow extends StatelessWidget {
  final PropertyUnitEntity unit;
  const PropertyStatsRow({required this.unit});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12.h,
      left: 2.w,
      right: 2.w,
      child: Row(
        children: [
          StatCard(
            flex: 2,
            title: LocaleKeys.area.tr(),
            value: unit.formattedSize,
          ),
          StatCard(
            title: LocaleKeys.bedrooms.tr(),
            value: unit.bedCount?.toString() ?? "0",
          ),
          StatCard(
            title: LocaleKeys.bathrooms.tr(),
            value: unit.bathCount?.toString() ?? "0",
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title, value;
  final int? flex;
  const StatCard({required this.title, required this.value, this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.accentBlue.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.backgroundWhite,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.backgroundWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ).mh(AppSizes.paddingXS.w),
    );
  }
}
