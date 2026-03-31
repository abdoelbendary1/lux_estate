import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/shared_spaces/presentation/widgets/StudentCommunityCard.dart';

class StudentFriendlySection extends StatelessWidget {
  const StudentFriendlySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان
        Text(
          "Student Friendly Communities",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 20.h),

        // الكارت الأول
        const StudentCommunityCard(
          title: "AUC Hub Commons",
          subtitle: "3 mins walk from AUC New Cairo",
          badgeText: "12 SPOTS LEFT",
          badgeColor: Color(0xFF4FC3F7), // Light Blue
          imageUrl: "assets/images/auc_hub.png",
        ),

        // الكارت الثاني
        const StudentCommunityCard(
          title: "The GUC Loft",
          subtitle: "Direct shuttle to campus",
          badgeText: "VERIFIED COMMUNITY",
          badgeColor: Color(0xFF66BB6A), // Green
          imageUrl: "assets/images/guc_loft.png",
        ),

        SizedBox(height: 12.h),

        // الزرار الكبير (Explore Button)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {}, // Navigate to all shared spaces
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // اللون الكحلي
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Explore All Shared Spaces",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ],
    ).m();
  }
}
