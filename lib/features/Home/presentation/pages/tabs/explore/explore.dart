import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/bloc/nearbyUnits/nearby_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/bloc/recentlyAdded/recently_added_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/bloc/recomended_units/recommended_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/widgets/home_appbar.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/nearby_units/widgets/nearby_section.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/recently_added/widgets/recently_added.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/recommended/recommended_swipe_card.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/search_appbar/search_appbar.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/shared/shared_units.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                ..add(LoadRecentlyAddedUnitsEvent()),
        ),
        // 3. Logic for Nearby units (passing location if available)
        BlocProvider(
          create: (context) => getIt<NearbyUnitsBloc>()
            ..add(
              LoadNearbyUnitsEvent(lat: '30.0570', lang: '31.3310'),
            ), // Example coords
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            body: BlocBuilder<SessionCubit, SessionState>(
              builder: (context, sessionState) {
                if (sessionState is SessionAuthenticated) {
                  return Column(
                    children: [
                      HomeAppBar(user: sessionState.user),
                      SearchSection(
                        onSearchTapped: () =>
                            context.pushNamed(AppRoutes.searchScreenName),
                        enabled: false,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary, // Background of the toggle
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: TabBar(
                          dividerColor: AppColors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: AppColors
                                .greenTagBg, // Matches your "Apartments" chip color
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          labelColor: AppColors.primary,
                          unselectedLabelColor: AppColors.greenTagBg,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: const [
                            Tab(text: "Full Residences"),
                            Tab(text: "Shared Spaces"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildExploreContent(context, sessionState.user),
                            SharedHousingTab(),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildExploreContent(BuildContext context, UserEntity user) {
  return RefreshIndicator(
    color: AppColors.primary,
    onRefresh: () async {
      context.read<RecommendedUnitsBloc>().add(
        LoadPropertiesByCategoryEvent(
          category: PropertyCategories.values.first,
        ),
      );
      context.read<RecentlyAddedUnitsBloc>().add(LoadRecentlyAddedUnitsEvent());
      context.read<NearbyUnitsBloc>().add(
        LoadNearbyUnitsEvent(lat: '30.0570', lang: '31.3310'),
      );
      await Future.delayed(const Duration(milliseconds: 800));
    },
    child: SafeArea(child: FullResidencesTab(user: user)),
  );
}

class FullResidencesTab extends StatelessWidget {
  const FullResidencesTab({super.key, this.user});
  final UserEntity? user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.only(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizes.spaceXS.verticalSpace,
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
