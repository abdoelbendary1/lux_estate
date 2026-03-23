import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class FeaturedPropertyCard extends StatelessWidget {
  const FeaturedPropertyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Allows card to shrink-wrap if needed
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. IMAGE SECTION - Now uses Expanded to be flexible
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=2070&auto=format&fit=crop',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Exclusive Listing Badge
                Positioned(
                  top: 16.h,
                  left: 16.w,
                  child: _buildBadge("EXCLUSIVE LISTING", Colors.green),
                ),
                // Heart Icon
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: _buildCircleIcon(Icons.favorite_border),
                ),
                // Price Badge (Matches the bottom-right design of the image)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: _buildPriceBadge("\$8,450,000"),
                ),
              ],
            ),
          ),

          // 2. DETAILS SECTION - Fixed content that defines the bottom space
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "The Azure Pavilion",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                    _buildLocationInfo("BEL AIR, CA"),
                  ],
                ),
                SizedBox(height: 16.h),
                // Feature Cards (Grid-like row)
                Row(
                  children: [
                    _buildFeatureCard(Icons.architecture, "12,400 SQ. FT"),
                    SizedBox(width: 8.w),
                    _buildFeatureCard(Icons.bed_outlined, "6 BEDROOMS"),
                    SizedBox(width: 8.w),
                    _buildFeatureCard(Icons.bathtub_outlined, "8 BATHS"),
                  ],
                ),
                SizedBox(height: 20.h),
                // Action Button
                _buildExploreButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets to keep the build method clean ---

  Widget _buildBadge(String text, Color dotColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: dotColor),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: AppColors.backgroundWhite.withOpacity(0.85),
      child: Icon(icon, color: Colors.blueGrey, size: 20.sp),
    );
  }

  Widget _buildPriceBadge(String price) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            price,
            style: TextStyle(
              color: AppColors.backgroundWhite,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(String en) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey),
        Text(
          en,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F9),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18.sp, color: const Color(0xFF0D0D54)),
            SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreButton() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: const Color(0xFF05054B),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "EXPLORE DETAILS",
            style: TextStyle(
              color: AppColors.backgroundWhite,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          SizedBox(width: 8.w),
          const Icon(
            Icons.arrow_forward,
            color: AppColors.backgroundWhite,
            size: 16,
          ),
        ],
      ),
    );
  }
}
