import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lux_estate/core/helpers/helpers.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

class RecentPropertyTile extends StatelessWidget {
  const RecentPropertyTile({super.key, required this.unit});
  final PropertyUnitEntity unit;

  @override
  Widget build(BuildContext context) {
    String formattedPrice = NumberFormat.compact().format(unit.price ?? 0);
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Square Image
          // Inside RecentPropertyTile Row:
          SizedBox(
            width: 120.w, // Define how wide the image should be
            child: AspectRatio(
              aspectRatio: 1, // Keep it a perfect square
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: buildPropertyImage(unit.imageUrl),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // 2. Details Column
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Badge & Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: getListColor(
                          unit.unitCategory?.id ?? "1",
                        ).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        unit.unitCategory?.name ?? "Apartment",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Text(
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        "\$$formattedPrice",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Property Name
                Text(
                  unit.name ?? "",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 4.h),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16.sp,
                      color: AppColors.grey,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      unit.location?.name ?? "",
                      style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }
}
