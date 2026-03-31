import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class BuildBadgeUi extends StatelessWidget {
  const BuildBadgeUi({super.key, this.badgeText});
  final String? badgeText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingS.w,
        vertical: AppSizes.paddingXS.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 3.r, backgroundColor: AppColors.greenTagBg),
          AppSizes.spaceS.horizontalSpace,
          Text(
            badgeText ?? "MATCHED",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
