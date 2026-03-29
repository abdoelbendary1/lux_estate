import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';
import 'package:lux_estate/core/utils/property_card/property_card_shimmer.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/bloc/recomended_units/recommended_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/widgets/category_section.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/widgets/property_card.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // CategorySection(),
        Padding(
          padding: EdgeInsets.only(
            left: AppSizes.paddingL.w,
            top: AppSizes.paddingXS.h,
            bottom: AppSizes.paddingM.h,
          ),
          child: Row(
            children: [
              Text(
                'Recommended for You',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: BlocBuilder<RecommendedUnitsBloc, RecommendedUnitsState>(
            builder: (context, state) {
              return AsyncViewBuilder<List<PropertyUnitEntity>>(
                state: state.featuredUnitsStatus,
                loadingWidget: _loadingCards(),
                onSuccess: (units) => LoadedCards(units: units),
                onEmpty: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingL.w,
                  ),
                  child: EmptyPropertiesWidget(
                    onRefresh: () {
                      context.read<RecommendedUnitsBloc>().add(
                        LoadPropertiesByCategoryEvent(
                          category: PropertyCategories
                              .all, // You can choose a default category or pass it as a parameter
                        ),
                      );
                    },
                    message: "No Units Found in this category",
                    actionText: "SHOW ALL UNITS",
                  ),
                ),
                onRetry: () => context.read<RecommendedUnitsBloc>().add(
                  LoadPropertiesByCategoryEvent(
                    category: PropertyCategories.villa,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _loadingCards() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        // Using a ratio is safer than a fixed height
        // 1 means height is approx 1.33x the width
        aspectRatio: 1,
        viewportFraction: 00.85, // Shows edges of side LoadedCards
        initialPage: 0,
        enlargeCenterPage: true, // Makes the UI look more premium
        enlargeFactor: 0.2,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: 1,
      itemBuilder: (context, index, realIndex) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: const PropertyCardShimmer(),
      ),
    );
  }
}

class LoadedCards extends StatelessWidget {
  LoadedCards({super.key, required this.units});
  List<PropertyUnitEntity> units;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            // Using a ratio is safer than a fixed height
            // 1 means height is approx 1.33x the width
            aspectRatio: 1,
            viewportFraction: 00.85, // Shows edges of side LoadedCards
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            enlargeCenterPage: true, // Makes the UI look more premium
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: units.length,
          itemBuilder: (context, index, realIndex) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: PropertyCard(
              propertyUnit: units[index],
              viewUnitDetails: () => context.pushNamed(
                AppRoutes.detailsScreenName,
                extra: units[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
