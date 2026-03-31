import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/bloc/nearbyUnits/nearby_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/nearby_units/widgets/nearbyCard.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/build_sectionHeader.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';
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
            BuildSectionHeader(
              title: LocaleKeys.nearby_units.tr(),
              onTrailing: () => context.pushNamed(
                AppRoutes.nearbyScreenName,
                extra: state.nearbyUnitsStatus.data,
              ),
              trailingText: LocaleKeys.see_all.tr(),
              hasTrailing: true,
            ).pOnly(
              b: AppSizes.paddingL,
              s: AppSizes.paddingM,
              t: AppSizes.paddingM,
            ),
            AsyncViewBuilder(
              state: state.nearbyUnitsStatus,
              loadingWidget: SizedBox(height: 260.h, child: _buildLoadingUI()),
              onEmpty: _buildEmptyUI(),
              onSuccess: (units) => _buildSuccessUI(units),
              onRetry: () => context.read<NearbyUnitsBloc>().add(
                LoadNearbyUnitsEvent(lat: '', lang: ''),
              ),
            ),
          ],
        ).ph(AppSizes.paddingS);
      },
    );
  }

  SizedBox _buildSuccessUI(List<PropertyUnitEntity> units) {
    return SizedBox(
      height: 260.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => context.pushNamed(
              AppRoutes.detailsScreenName,
              extra: units[index],
            ),
            child: NearbyCard(unit: units[index]).mOnly(s: AppSizes.marginS),
          );
        },
      ),
    );
  }

  ListView _buildLoadingUI() {
    return ListView.separated(
      // itemExtent: 250.w,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(width: 16.w),
      itemBuilder: (context, index) {
        return BuildShimmerCardNearbySection();
      },
    );
  }

  Widget _buildEmptyUI() {
    return AspectRatio(
      aspectRatio: 1.3,
      child: EmptyPropertiesWidget(
        message: LocaleKeys.no_units_found.tr(),
        actionText: LocaleKeys.show_all_units.tr(),
      ),
    ).ph(AppSizes.paddingM);
  }
}

class BuildShimmerCardNearbySection extends StatelessWidget {
  const BuildShimmerCardNearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.9,

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
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
}
