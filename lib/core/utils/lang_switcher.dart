import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Icon(
            Icons.language,
            size: AppSizes.iconL,
            color: AppColors.primary,
          ),
        ),
        AppSizes.paddingXS.horizontalSpace,
        // Text(
        //   'ENGLISH',
        //   style: Theme.of(
        //     context,
        //   ).textTheme.bodySmall!.copyWith(color: AppColors.grey),
        // ),
      ],
    );
  }
}
