import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/filter_chip.dart';

class BuildFilterAndSortUI extends StatelessWidget {
  const BuildFilterAndSortUI({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppFilterChip(
                isSelected: false,
                displayName: 'Filters',
                hasIcon: true,
                icon: Icons.tune,
                onSelected: (p0) {},
              ),
              AppSizes.spaceS.horizontalSpace,
              AppFilterChip(
                isSelected: false,
                displayName: 'Male Only',
                onSelected: (p0) {},
              ),
              AppSizes.spaceS.horizontalSpace,
              AppFilterChip(
                isSelected: false,
                displayName: 'Female Only',
                onSelected: (p0) {},
              ),
              AppSizes.spaceS.horizontalSpace,
              AppFilterChip(
                isSelected: false,
                displayName: 'Private Room',
                onSelected: (p0) {},
              ),
              AppSizes.spaceS.horizontalSpace,
            ],
          ).mOnly(
            t: AppSizes.marginS,
            b: AppSizes.marginM,
            s: AppSizes.marginL,
            e: AppSizes.marginL,
          ),
    );
  }
}
