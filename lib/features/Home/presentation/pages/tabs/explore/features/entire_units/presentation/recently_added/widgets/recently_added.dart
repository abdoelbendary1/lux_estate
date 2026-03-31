import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/build_sectionHeader.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/bloc/recentlyAdded/recently_added_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recently_added/widgets/RecentPropertyShimmerTile.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recently_added/widgets/recent_property.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class RecentlyAddedSection extends StatelessWidget {
  const RecentlyAddedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyAddedUnitsBloc, RecentlyAddedUnitsState>(
      builder: (context, state) {
        return Column(
          children: [
            BuildSectionHeader(
              title: LocaleKeys.recently_added.tr(),
              hasTrailing: true,
              onTrailing: () {
                context.pushNamed(
                  AppRoutes.recentlyAdedScreenName,
                  extra: state.unitsStatus.data,
                );
              },
              trailingText: LocaleKeys.see_all.tr(),
            ).pOnly(b: AppSizes.paddingL),
            AsyncViewBuilder(
              state: state.unitsStatus,
              loadingWidget: _buildLoadingUI(),
              onEmpty: _buildEmptyUI(),
              onSuccess: (units) => _buildSuccess(units),
              onRetry: () => context.read<RecentlyAddedUnitsBloc>().add(
                LoadRecentlyAddedUnitsEvent(),
              ),
            ),
          ],
        ).pOnly(s: AppSizes.paddingM, t: AppSizes.paddingM);
      },
    );
  }

  ListView _buildLoadingUI() {
    return ListView.builder(
      shrinkWrap: true, // Only if inside another Scrollable
      physics:
          const NeverScrollableScrollPhysics(), // If inside another Scrollable
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 3, // Show 5 skeleton tiles
      itemBuilder: (context, index) {
        return const RecentPropertyShimmerTile();
      },
    );
  }

  AspectRatio _buildEmptyUI() {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingL.w),
        child: EmptyPropertiesWidget(
          message: LocaleKeys.no_units_found.tr(),
          actionText: LocaleKeys.show_all_units.tr(),
        ),
      ),
    );
  }

  ListView _buildSuccess(List<PropertyUnitEntity> units) {
    return ListView.builder(
      shrinkWrap: true, // Crucial: Tells ListView to take only needed space
      physics: const NeverScrollableScrollPhysics(), // Let the parent scroll
      itemCount: 3,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () =>
            context.pushNamed(AppRoutes.detailsScreenName, extra: units[index]),
        child: RecentPropertyTile(unit: units[index]),
      ),
    );
  }
}
