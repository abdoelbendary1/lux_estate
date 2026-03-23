import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/widgets/recent_property.dart';

class RecentlyAddedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.paddingM.h,
        horizontal: AppSizes.paddingM.w,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recently Added',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Explore all',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
                ),
              ),
            ],
          ),
          AppSizes.spaceS.verticalSpace,
          RecentPropertyTile(),
          RecentPropertyTile(),
        ],
      ),
    );
  }
}
