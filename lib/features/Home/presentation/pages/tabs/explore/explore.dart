import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lux_estate/core/cubits/locale/locale_cubit.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/bloc/nearbyUnits/nearby_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/bloc/recentlyAdded/recently_added_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recommended/recomended_units/recommended_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/widgets/build_exploreView.dart';


class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 1. Logic for Category filtering and Recommended units
        BlocProvider(
          create: (context) => getIt<RecommendedUnitsBloc>()
            ..add(
              LoadPropertiesByCategoryEvent(
                category: PropertyCategories.values.first,
              ),
            ),
        ),
        // 2. Logic for Recently Added units
        BlocProvider(
          create: (context) =>
              getIt<RecentlyAddedUnitsBloc>()
                ..add(LoadRecentlyAddedUnitsEvent( category: PropertyCategories.values.first,)),
        ),
        // 3. Logic for Nearby units (passing location if available)
        BlocProvider(
          create: (context) => getIt<NearbyUnitsBloc>()
            ..add(
              LoadNearbyUnitsEvent(lat: '30.0570', lang: '31.3310', category: PropertyCategories.values.first),
            ), // Example coords
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, state) {
          return ExploreUIView();
        },
      ),
    );
  }
}
