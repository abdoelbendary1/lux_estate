import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class SearchPlaceHolder extends StatelessWidget {
  const SearchPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppSizes.spaceL.verticalSpace,
          Image.asset(AppAssetsPath.searchPlaceHolder, height: 200.h),
          Text(
            "Search for properties",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
