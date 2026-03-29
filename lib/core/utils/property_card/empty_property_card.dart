import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/app_button.dart';

class EmptyPropertiesWidget extends StatelessWidget {
  final VoidCallback? onRefresh;
  final String message;
  final String actionText;

  const EmptyPropertiesWidget({
    super.key,
    this.onRefresh,
    this.actionText = "Refresh",
    this.message = "No properties found in this category",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingM.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          // أيقونة مع خلفية خفيفة
          Image.asset(
            AppAssetsPath.noUnitsFound,
            height: 200.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.h),
          // نص الرسالة
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Spacer(),
          // زرار لإعادة المحاولة أو مسح الفلاتر
          Visibility(
            visible: onRefresh != null,
            child: BuildAppButton(onTap: onRefresh, actionText: actionText),
          ),
          // SizedBox(height: 30.h),
          Spacer(),
        ],
      ),
    );
  }
}
