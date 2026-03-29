import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/bloc/nearbyUnits/nearby_units_bloc.dart';
import 'package:shimmer/shimmer.dart';

class NearbySection extends StatelessWidget {
  const NearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyUnitsBloc, NearbyUnitsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nearby Selection",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0D0D54),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      state.nearbyUnitsStatus is DataSuccess
                          ? context.pushNamed(
                              AppRoutes.nearbyScreenName,
                              extra: state.nearbyUnitsStatus.data,
                            )
                          : null;
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AsyncViewBuilder(
              state: state.nearbyUnitsStatus,
              loadingWidget: SizedBox(
                height: 260.h,

                child: ListView.separated(
                  // itemExtent: 250.w,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (context, index) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    return _buildSmallPropertyCardShimmer();
                  },
                ),
              ),
              onEmpty: AspectRatio(
                aspectRatio: 1.3,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingL.w,
                  ),
                  child: EmptyPropertiesWidget(
                    message: "No Units Found",
                    actionText: "SHOW ALL UNITS",
                  ),
                ),
              ),
              onSuccess: (units) => SizedBox(
                height: 260.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (context, index) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => context.pushNamed(
                        AppRoutes.detailsScreenName,
                        extra: units[index],
                      ),
                      child: _buildSmallPropertyCard(units[index]),
                    );
                  },
                ),
              ),
              onRetry: () => context.read<NearbyUnitsBloc>().add(
                LoadNearbyUnitsEvent(lat: '', lang: ''),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSmallPropertyCardShimmer() {
    return AspectRatio(
      aspectRatio: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: BorderDirectional(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 15.w,
            ), // Faded border
          ),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Placeholder
              Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
              ),

              // Content Area
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingS.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      // Title placeholder
                      Container(
                        width: 140.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Location placeholder
                          Container(
                            width: 80.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          // Price placeholder
                          Container(
                            width: 60.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
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

  Widget _buildSmallPropertyCard(PropertyUnitEntity unit) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: Container(
        // width: 260.w,
        // Remove fixed height here to let it fill the parent SizedBox
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: BorderDirectional(
            bottom: BorderSide(color: AppColors.secondary, width: 15.w),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Card only takes needed space
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flexible Image Header
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              child: SizedBox(
                height: 160.h, // Control image height specifically
                width: double.infinity,
                child: buildPropertyImage(unit.imageUrl),
              ),
            ),

            // Flexible Content Area
            Expanded(
              // This makes the text area "eat" the remaining space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: AppSizes.paddingS.w,
                      vertical: AppSizes.paddingXS.h,
                    ),
                    child: Text(
                      unit.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: AppSizes.paddingS.w,
                      vertical: AppSizes.paddingS.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            unit.location?.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          "\$${NumberFormat('#,###').format(unit.price ?? 0)}",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
