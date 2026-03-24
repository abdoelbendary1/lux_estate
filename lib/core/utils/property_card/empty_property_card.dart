import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),

          // أيقونة مع خلفية خفيفة
          Image.asset(AppAssetsPath.noUnitsFound, height: 250.h),
          SizedBox(height: 8.h),
          // نص الرسالة
          Text(
            message,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 32.h),
          // زرار لإعادة المحاولة أو مسح الفلاتر
          if (onRefresh != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingL.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRefresh,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    actionText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
