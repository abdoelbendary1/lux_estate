import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class BuildSortChipUI extends StatelessWidget {
  const BuildSortChipUI({super.key, required this.label});
  final String label;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(width: 4.w),
 Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primary,
            size: 16.sp,
          ),
        ],
      ),
    );
  }
}
