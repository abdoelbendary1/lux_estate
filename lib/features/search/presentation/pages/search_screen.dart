import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';
import 'package:lux_estate/core/utils/property_card/filter_dialog.dart';
import 'package:lux_estate/core/utils/property_card/property_card_shimmer.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/property_card.dart';
import 'package:lux_estate/features/search/presentation/pages/widgets/search_appbar/search_appbar.dart';
import 'package:lux_estate/features/search/presentation/bloc/filter/filter_cubit.dart';
import 'package:lux_estate/features/search/presentation/bloc/search_bloc.dart';
import 'package:lux_estate/features/search/presentation/pages/widgets/search_placeholder.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  bool isFiltering = false;
  // void openFilterDialog(
  //   BuildContext context,
  //   List<PropertyCategories>? filteredCategories,
  // ) async {
  //   // 1. Capture the bloc from the current context
  //   final searchBloc = context.read<SearchBloc>();

  //   await FilterListDialog.display<PropertyCategories>(
  //     choiceChipLabel: (category) => category?.displayName,
  //     validateSelectedItem: (list, item) {
  //       return list?.contains(item) ?? false;
  //     },
  //     onItemSearch: (item, query) {
  //       return item.displayName.toLowerCase().contains(query.toLowerCase());
  //     },
  //     onApplyButtonClick: (list) {
  //       searchBloc.add(
  //         SelectFilterCategories(categories: List.from(list ?? [])),
  //       );
  //     },
  //     context,
  //     listData: PropertyCategories.values,
  //     selectedListData: filteredCategories,
  //     // ... other properties
  //     choiceChipBuilder: (context, item, isSelected) {
  //       // 2. Wrap your chip in a BlocProvider.value so the dialog's context can see it
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return BlocProvider.value(
  //             value: searchBloc,
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: AppSizes.paddingS.w,
  //                 vertical: AppSizes.paddingS.h,
  //               ),
  //               child: AppFilterChip(
  //                 displayName: (item as PropertyCategories).displayName,
  //                 isSelected: isSelected ?? false,
  //                 onSelected: (selected) {
  //                   // This will no longer throw an error
  //                   searchBloc.add(
  //                     SelectFilterCategories(
  //                       categories: List.from(
  //                         searchBloc.state.filteredCategories ?? [],
  //                       )..add(item),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //     // ... rest of your code
  //   );
  // }
  void _openFilter(BuildContext context) async {
    // We capture the existing Bloc instance
    final filterBloc = context.read<FilterBloc>();
    await Future.delayed(const Duration(milliseconds: 150));
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Filter",
      barrierColor: Colors.black54, // Darkens the background
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        // We Wrap the Dialog in the BlocProvider.value so it has access to the state
        return BlocProvider.value(
          value: filterBloc,
          child: const PropertyFilterDialog(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        // This creates a smooth slide-up effect
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FilterBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppSizes.spaceL.verticalSpace,

                  Padding(
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
                          "${state.unitsStatus.data?.length ?? 0} premium residences found in your selected architectural zones.",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),

                  BlocListener<FilterBloc, FilterState>(
                    listener: (context, state) {
                      isFiltering ? _openFilter(context) : null;
                    },
                    child: SearchSection(
                      autoFocus: true,
                      onSubmitted: (query) => context.read<SearchBloc>().add(
                        PerformSearch(query: query),
                      ),
                      onFilterTapped: () => _openFilter(context),
                    ),
                  ),
                  _buildUIView(context, state),
                ],
              );
            },
          ),
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
          context.pushNamed(AppRoutes.exploreScreenName);
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
            isDataVisible: true,
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
