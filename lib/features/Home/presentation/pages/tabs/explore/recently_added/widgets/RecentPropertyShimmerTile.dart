import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RecentPropertyShimmerTile extends StatelessWidget {
  const RecentPropertyShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Shimmer Square Image
            Container(
              width: 120.w,
              height: 120.h, // Fixed height to match AspectRatio(1)
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(width: 16.w),

            // 2. Shimmer Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Badge & Price Shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      Container(
                        width: 80.w,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Property Name Shimmer
                  Container(
                    width: double.infinity,
                    height: 18.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h),

                  // Location Shimmer
                  Row(
                    children: [
                      Container(
                        width: 16.w,
                        height: 16.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        width: 100.w,
                        height: 14.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
          ],
        ),
      ),
    );
  }
}