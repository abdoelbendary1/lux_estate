import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/bloc/nearbyUnits/nearby_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/bloc/recentlyAdded/recently_added_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/nearby_units/widgets/nearby_section.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recently_added/widgets/recently_added.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recommended/recommended_swipe_card.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recommended/recomended_units/recommended_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/category_section.dart';

class FullResidencesTab extends StatelessWidget {
  const FullResidencesTab({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        context.read<RecommendedUnitsBloc>().add(
          LoadPropertiesByCategoryEvent(
            category: PropertyCategories.values.first,
          ),
        );
        context.read<RecentlyAddedUnitsBloc>().add(
          LoadRecentlyAddedUnitsEvent(
            category: PropertyCategories.values.first,
          ),
        );
        context.read<NearbyUnitsBloc>().add(
          LoadNearbyUnitsEvent(
            lat: '30.0570',
            lang: '31.3310',
            category: PropertyCategories.values.first,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 800));
      },
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategorySection(),
            RecommendedSection(),
            RecentlyAddedSection(),
            NearbySection(),

            // CallSupportCard(),
            BlocBuilder<NavbarVisibilityCubit, bool>(
              builder: (context, state) {
                return state ? 80.h.verticalSpace : 50.h.verticalSpace;
              },
            ),
          ],
        ),
      ),
    );
  }
}
