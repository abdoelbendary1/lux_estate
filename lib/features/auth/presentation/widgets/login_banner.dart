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
      alignment: AlignmentGeometry.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.h), // مساحة للـ badge
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                // color: AppColors.primary.withOpacity(0.1),
                height: 200.h,
                child: Image.asset(
                  AppAssetsPath.background,
                  // height: 200.h,
                  width: double.infinity,
                  alignment: AlignmentGeometry.bottomCenter,
                  fit: BoxFit.scaleDown,
                ),
              ),

              /// Badge
              Positioned(
                bottom: -20.h,
                right: 15.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EST. 2024',
                        style: theme.textTheme.bodySmall!.copyWith(
                          fontSize: 8.sp,
                        ),
                      ),
                      Text(
                        'CURATED LIVING',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pa
