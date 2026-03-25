import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';
import 'package:lux_estate/core/utils/property_card/property_card_shimmer.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/widgets/property_card.dart';
import 'package:lux_estate/features/Home/presentation/widgets/search_appbar.dart';
import 'package:lux_estate/features/search/presentation/bloc/search_bloc.dart';
import 'package:lux_estate/features/search/presentation/pages/widgets/search_placeholder.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AppSizes.spaceL.verticalSpace,
                state.unitsStatus is DataSuccess
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingL.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Search Results",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            AppSizes.spaceS.verticalSpace,
                            Text(
                              "${state.unitsStatus.data?.length} premium residences found in your selected architectural zones.",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),

                SearchSection(
                  autoFocus: true,
                  onSubmitted: (query) => context.read<SearchBloc>().add(
                    PerformSearch(query: query),
                  ),
                ),
                _buildUIView(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUIView(BuildContext context, SearchState state) => Expanded(
    // Changed from SizedBox to Expanded
    child: AsyncViewBuilder<List<PropertyUnitEntity>>(
      state: state.unitsStatus,
      initialWidget: const SearchPlaceHolder(),
      onSuccess: (units) => _buildSuccessUI(units),
      onEmpty: _buildEmptyUI(context),
      // If you use a single widget for loading, wrap it in Center
      loadingWidget: _buildLoadingUI(),
      onRetry: () {},
    ),
  );

  ListView _buildLoadingUI() {
    return ListView.builder(
      padding: EdgeInsets.zero, // Ensures list starts exactly where you want
      itemCount: 3,
      itemBuilder: (context, index) => AspectRatio(
        aspectRatio: 1.2,

        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingL.w,
            vertical: AppSizes.paddingS.h,
          ),

          child: PropertyCardShimmer(),
        ),
      ),
    );
  }

  Widget _buildEmptyUI(BuildContext context) {
    return Center(
      child: EmptyPropertiesWidget(
        onRefresh: () {
          context.goNamed(AppRoutes.homeName);
        },
        message: "No Units Found",
        actionText: "Go back Home",
      ),
    );
  }

  ListView _buildSuccessUI(List<PropertyUnitEntity> units) {
    return ListView.builder(
      // itemExtent: 400.h,
      padding: EdgeInsets.zero, // Ensures list starts exactly where you want
      itemCount: units.length,
      itemBuilder: (context, index) => AspectRatio(
        aspectRatio: 1.2,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingL.w,
            vertical: AppSizes.paddingS.h,
          ),

          child: PropertyCard(
            propertyUnit: units[index],
            viewUnitDetails: () {
              context.pushNamed(
                AppRoutes.detailsScreenName,
                extra: units[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
