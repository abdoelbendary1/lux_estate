import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/helpers/helpers.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/utils/app_button.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.propertyUnit,
    this.viewUnitDetails,
    this.onSaveToggle,
    this.isDataVisable = false,
  });
  final PropertyUnitEntity propertyUnit;
  final VoidCallback? viewUnitDetails;
  final bool isDataVisable;
  final VoidCallback? onSaveToggle;

  @override
  Widget build(BuildContext context) {
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
      child: GestureDetector(
        onTap: viewUnitDetails,
        behavior: HitTestBehavior.opaque, // Ensures the whole area is clickable
        child: Column(
          mainAxisSize: MainAxisSize.min, // Shrink wrap content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image Section - Takes up the available space
            Expanded(
              // Using Expanded here allows the carousel's height to dictate the image size
              child: Stack(
                children: [
                  //Image with Gradient Overlay and Badges
                  _buildImage(),
                  // Gradient Overlay
                  _buildGradient(),
                  // "MATCHED" Badge
                  _buildBadge(),
                  // Heart Icon
                  _buildSaveUI(),

                  // Property Details on Image
                  _buildStatsRow(),
                ],
              ),
            ),

            // 2. Bottom Info Section - Fixed height portion
            Visibility(
              visible: !isDataVisable,
              child: Row(
                children: [
                  // 1. Wrap the text info in Expanded so it occupies available space
                  Expanded(
                    child: BuildAppButton(
                      curvedTop: false,
                      onTap: viewUnitDetails,
                      actionText: "Explore Details",
                      trailingIcon: Icons.arrow_forward,
                    ),
                  ),
                ],
              ),
            ),
            _buildPriceRow(
              propertyUnit,
              formatPrice(propertyUnit),
              isDataVisable,
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildSaveUI() {
    return Positioned(
      top: 12.h,
      right: 12.w,
      child: CircleAvatar(
        radius: 25.r,
        backgroundColor: AppColors.backgroundWhite.withOpacity(0.9),
        child: IconButton(
          onPressed: () => onSaveToggle,
          icon: Icon(
            applyTextScaling: true,
            Icons.favorite,
            color: propertyUnit.isSaved == true
                ? AppColors.error
                : AppColors.grey.withOpacity(0.6),
            size: 30.sp,
          ),
        ),
      ),
    );
  }

  Positioned _buildGradient() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.transparent, AppColors.black.withOpacity(0.8)],
            stops: const [0.6, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return propertyUnit.isMatched ?? false
        ? Positioned(
            top: 12.h,
            left: 12.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(radius: 3, backgroundColor: Colors.green),
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
        : const SizedBox.shrink();
  }

  ClipRRect _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: buildPropertyImage(propertyUnit.imageUrl),
    );
  }

  Widget _buildStatsRow() {
    return Positioned(
      bottom: 12.h,
      left: 8.w,
      right: 8.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildStatCard(
            flex: 7,
            title: 'METERS SQ.',
            value: convertFromSqFtToSqMeters(
              propertyUnit.size?.toDouble() ?? 0.0,
            ).toString(),
          ),
          Spacer(flex: 1),
          _buildStatCard(
            flex: 4,
            title: 'BEDS',
            value: propertyUnit.bedCount?.toInt().toString() ?? "N/A",
          ),
          Spacer(flex: 1),

          _buildStatCard(
            flex: 4,
            title: 'BATHS',
            value: propertyUnit.bathCount?.toInt().toString() ?? "N/A",
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    int? flex,
  }) => Expanded(
    flex: flex ?? 1,
    child: Container(
      width: 100.w,
      height: 110.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.accentBlue.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget _buildPriceRow(
    PropertyUnitEntity propertyUnit,
    String formattedPrice,
    bool isVisible, // Fixed typo from 'isVisable'
  ) {
    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.end, // Aligns price and text to bottom
          children: [
            // LEFT SIDE: Name and Location
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Takes only space it needs
                children: [
                  Text(
                    propertyUnit.name ?? '',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20.sp, // Slightly reduced to fit better
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 4.h,
                  ), // Consistent spacing instead of Spacer()
                  if (propertyUnit.location?.name != null)
                    Row(
                      // Horizontal layout for icon and text looks better in rows
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primary,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            propertyUnit.location!.name!.toUpperCase(),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            SizedBox(width: 10.w), // Gap between info and price
            // RIGHT SIDE: Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "INVESTMENT PRICE",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$$formattedPrice',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
