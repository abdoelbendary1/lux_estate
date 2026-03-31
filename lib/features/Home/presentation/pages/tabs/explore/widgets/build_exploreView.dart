import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/FullResidencesTab.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/home_appbar.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/shared_spaces/presentation/shared_units.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class ExploreUIView extends StatelessWidget {
  const ExploreUIView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(),
              _buildTabsLabel(context),
              Expanded(
                child: TabBarView(
                  children: [FullResidencesTab(), SharedHousingTab()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabsLabel(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite, // Background of the toggle
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TabBar(
        automaticIndicatorColorAdjustment: true,
        labelStyle: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: AppColors.textWhite),
        tabs: [
          Tab(text: LocaleKeys.entire_units.tr()),
          Tab(text: LocaleKeys.shared_spaces.tr()),
        ],
      ),
    ).mOnly(b: AppSizes.marginS, s: AppSizes.marginM, e: AppSizes.marginM);
  }
}
