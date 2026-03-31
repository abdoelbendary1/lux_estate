import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';

class StudentCommunityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final String imageUrl;
  final Color badgeColor;

  const StudentCommunityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.imageUrl,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // الصورة المصغرة (Thumbnail)
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: 80.w,
              height: 80.h,
              child: buildPropertyImage(imageUrl),
            ),
          ),
          SizedBox(width: 16.w),

          // البيانات النصية
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary, // اللون الداكن اللي عندك
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 8.h),

                // الـ Badge الصغير
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.2), // خلفية باهتة
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    badgeText.toUpperCase(),
                    style: TextStyle(
                      color: badgeColor, // لون النص غامق
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
