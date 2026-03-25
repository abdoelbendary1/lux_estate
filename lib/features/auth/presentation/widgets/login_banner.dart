import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class LoginBanner extends StatelessWidget {
  const LoginBanner({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Stack(
          // Allow the badge to overflow the stack boundaries
          clipBehavior: Clip.none,
          children: [
            // 1. Image with fixed Aspect Ratio
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
              child: AspectRatio(
                aspectRatio: 1.2, // Higher number = wider, lower = taller
                child: Image.asset(
                  AppAssetsPath.background,
                  width: double.infinity,
                  fit: BoxFit.cover, // Cover ensures the box is filled
                ),
              ),
            ),

            // 2. Badge positioned relative to the image
            Positioned(
              bottom: -15.h, // Adjusted to look consistent
              right: 15.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'EST. 2024',
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      'CURATED LIVING',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
