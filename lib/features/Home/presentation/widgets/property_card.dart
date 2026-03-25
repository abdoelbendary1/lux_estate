import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.propertyUnit,
    this.viewUnitDetails,
  });
  final PropertyUnitEntity propertyUnit;
  final VoidCallback? viewUnitDetails;

  @override
  Widget build(BuildContext context) {
    String formattedPrice = NumberFormat(
      '#,###',
    ).format(propertyUnit.price ?? 0);
    return Container(
      // Removed fixed height to let content define size or be driven by Carousel aspectRatio
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Shrink wrap content
        children: [
          // 1. Image Section - Takes up the available space
          Expanded(
            // Using Expanded here allows the carousel's height to dictate the image size
            child: Stack(
              children: [
                //Image with Gradient Overlay and Badges
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                  child: buildPropertyImage(propertyUnit.imageUrl),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                // "MATCHED" Badge
                propertyUnit.isMatched ?? false
                    ? Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircleAvatar(
                                radius: 3,
                                backgroundColor: Colors.green,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "MATCHED",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                // Heart Icon
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: Icon(
                      Icons.favorite,
                      color: propertyUnit.isSaved == true
                          ? Colors.redAccent
                          : Colors.grey[400],
                      size: 20.sp,
                    ),
                  ),
                ),
                // Property Details on Image
                Positioned(
                  bottom: 12.h,
                  left: 16.w,
                  right: 16.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [_buildStatsRow(propertyUnit)],
                  ),
                ),
              ],
            ),
          ),

          // 2. Bottom Info Section - Fixed height portion
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      propertyUnit.name ?? '',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22.sp, // Adjusted from 28 to be more flexible
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    propertyUnit.location?.name?.toUpperCase() != null
                        ? Text(
                            propertyUnit.location?.name?.toUpperCase() ?? '',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.sp,
                            ),
                          )
                        : const SizedBox.shrink(),
                    propertyUnit.location?.name?.toUpperCase() != null
                        ? SizedBox(height: 4.h)
                        : const SizedBox.shrink(),

                    Text(
                      "INVESTMENT PRICE",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '\$${formattedPrice}',
                      style: TextStyle(
                        fontSize: 22.sp, // Adjusted to be readable
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
                ElevatedButton(
                  onPressed: viewUnitDetails,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "View Detail",
                    style: TextStyle(
                      fontSize: 14.sp,
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

  // Widget _buildInfoIcon(IconData icon, String text) {
  //   return Row(
  //     children: [
  //       Icon(icon, color: Colors.white, size: 22.sp),
  //       SizedBox(width: 4.w),
  //       Text(
  //         text,
  //         style: TextStyle(color: Colors.white, fontSize: 20.sp),
  //       ),
  //     ],
  //   );
  // }
  int convertFromSqFtToSqMeters(double sqFt) {
    double sqMeters = sqFt * 0.0929;
    return sqMeters.toInt();
  }

  Widget _buildStatsRow(PropertyUnitEntity unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildStatCard(
          title: 'METERS SQ.',
          value: convertFromSqFtToSqMeters(
            unit.size?.toDouble() ?? 0.0,
          ).toString(),
        ),
        Spacer(),
        _buildStatCard(
          title: 'BEDS',
          value: unit.bedCount?.toInt().toString() ?? "N/A",
        ),
        Spacer(),

        _buildStatCard(
          title: 'BATHROOMS',
          value: unit.bathCount?.toInt().toString() ?? "N/A",
        ),
      ],
    );
  }

  Widget _buildStatCard({required String title, required String value}) =>
      Expanded(
        flex: 20,
        child: Container(
          width: 100.w,
          height: 110.h,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.accentBlue.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 40.sp,
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
