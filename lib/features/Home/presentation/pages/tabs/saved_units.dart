import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/features/Home/data/datasource/home_page_mockup_data_source.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/category_section.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/property_card.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recommended/recomended_units/recommended_units_bloc.dart';

class SavedUnitsTab extends StatelessWidget {
  SavedUnitsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            AppColors.backgroundWhite, // Soft background from image
        body: _buildSuccessUI(),
      ),
    );
  }

  final HomePageMockupDataSourceImpl _dataSourceImpl =
      HomePageMockupDataSourceImpl();

  Widget _buildSuccessUI() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // AppSizes.spaceXL.verticalSpace,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Text(
          'CURATED FOR YOU',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.accentBlue,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          'Saved Units',
          textAlign: TextAlign.start,
          style: TextStyle(
            letterSpacing: 1.2,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      BlocProvider.value(
        value: getIt<RecommendedUnitsBloc>(),
        child: CategorySection(),
      ),
      Expanded(
        child: _buildSavedUnitList(_dataSourceImpl.getMockedProperties()),
      ),
      // SearchSection(hasFilter: false, hintText: "Search"),
    ],
  );

  Widget _buildSavedUnitList(List<PropertyUnitEntity> units) {
    return ListView.separated(
      itemBuilder: (context, index) => AspectRatio(
        aspectRatio: 0.9,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: units.length,
    );
  }
}
