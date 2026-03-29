import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/bloc/recentlyAdded/recently_added_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/recently_added/widgets/RecentPropertyShimmerTile.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/recently_added/widgets/recent_property.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';

class RecentlyAddedSection extends StatelessWidget {
  const RecentlyAddedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyAddedUnitsBloc, RecentlyAddedUnitsState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.paddingM.h,
            horizontal: AppSizes.paddingM.w,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recently Added',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(
                        AppRoutes.recentlyAdedScreenName,
                        extra: state.unitsStatus.data,
                      );
                    },
                    child: Text(
                      'Explore all',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              AsyncViewBuilder(
                state: state.unitsStatus,
                loadingWidget: ListView.builder(
                  shrinkWrap: true, // Only if inside another Scrollable
                  physics:
                      const NeverScrollableScrollPhysics(), // If inside another Scrollable
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: 3, // Show 5 skeleton tiles
                  itemBuilder: (context, index) {
                    return const RecentPropertyShimmerTile();
                  },
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
                onSuccess: (units) {
                  return ListView.builder(
                    shrinkWrap:
                        true, // Crucial: Tells ListView to take only needed space
                    physics:
                        const NeverScrollableScrollPhysics(), // Let the parent scroll
                    itemCount: 3,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => context.pushNamed(
                        AppRoutes.detailsScreenName,
                        extra: units[index],
                      ),
                      child: RecentPropertyTile(unit: units[index]),
                    ),
                  );
                },
                onRetry: () => context.read<RecentlyAddedUnitsBloc>().add(
                  LoadRecentlyAddedUnitsEvent(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
