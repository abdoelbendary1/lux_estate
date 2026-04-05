import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/property_card.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/presentation/widgets/saved_property.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class SavedUnitsTab extends StatelessWidget {
  const SavedUnitsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            AppColors.backgroundWhite, // Soft background from image
        body: BlocProvider.value(
          value: getIt<FavoritesBloc>()..add(const LoadFavoritesEvent()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              //   child: Text(
              //     LocaleKeys.show_all_favorites.tr(),
              //     textAlign: TextAlign.start,
              //     style: TextStyle(
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       color: AppColors.accentBlue,
              //     ),
              //   ),
              // ),
              Text(
                LocaleKeys.show_all_favorites.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              // SingleChildScrollView(
              //   physics: const BouncingScrollPhysics(),
              //   scrollDirection: Axis.horizontal,
              //   child: CategorySection(),
              // ),
              // حدد النوع هنا عشان الـ IDE يساعدك في الـ Auto-complete
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  // هنا الـ state.favoritesListStatus نوعها AsyncState<List<PropertyUnitEntity>>
                  return Expanded(
                    child: AsyncViewBuilder<List<PropertyUnitEntity>>(
                      state: state.favoritesListStatus,
                      onSuccess: (units) => _buildSuccessUI(units),
                      onEmpty: Center(
                        child: EmptyPropertiesWidget(
                          message: LocaleKeys.no_favorites_found.tr(),
                          onRefresh: () => context.read<FavoritesBloc>().add(
                            const LoadFavoritesEvent(),
                          ),
                          actionText: LocaleKeys.show_all_units.tr(),
                        ),
                      ), // اتأكد إنها Const لو أمكن
                      onRetry: () => context.read<FavoritesBloc>().add(
                        const LoadFavoritesEvent(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSuccessUI(List<PropertyUnitEntity> units) {
  //   // لو اللستة فاضية، لازم تعرض Placeholder بدل ما تعرض شاشة بيضاء
  //   if (units.isEmpty) {
  //     return const Center(child: Text("No saved properties yet."));
  //   }

  //   return Column(
  //     children: [
  //       // استخدمنا الـ Expanded هنا عشان الـ ListView تاخد باقي المساحة صح
  //       Expanded(child: _buildSavedUnitList(units)),
  //     ],
  //   );
  // }

  Widget _buildSavedUnitList(List<PropertyUnitEntity> units) {
    return ListView.separated(
      shrinkWrap: true,
      // تحسين الأداء: الـ padding يكون للـ ListView نفسها مش لكل item
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      physics: const BouncingScrollPhysics(), // بيدي إحساس الـ iOS الفخم
      itemCount: units.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final unit = units[index];

        // ابعد عن الـ AspectRatio الثابت لو الكارت جواه داتا متغيرة كتير
        // جرب تستخدم SizedBox بارتفاع محدد أو سيب الكارت ياخد مساحته الطبيعية
        return PropertyCard(
          isDataVisible: true,
          propertyUnit: unit,
          viewUnitDetails: () {
            context.pushNamed(AppRoutes.detailsScreenName, extra: unit);
          },
        );
      },
    );
  }

  Widget _buildSuccessUI(List<PropertyUnitEntity> units) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header Section
        // Padding(
        //   padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 15.h),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Saved Collections",
        //         style: TextStyle(
        //           fontSize: 26.sp,
        //           fontWeight: FontWeight.bold,
        //           color: const Color(0xFF0D0D4B),
        //         ),
        //       ),
        //       SizedBox(height: 4.h),
        //       Text(
        //         "${units.length} Premium properties curated for your portfolio",
        //         style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
        //       ),
        //     ],
        //   ),
        // ),

        // 2. Category Chips (Horizontal Scroll)
        // SizedBox(
        //   height: 50.h,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     padding: EdgeInsets.symmetric(horizontal: 20.w),
        //     children: [
        //       _buildFilterChip("All Properties", isSelected: true),
        //       _buildFilterChip("Villas"),
        //       _buildFilterChip("Penthouses"),
        //       _buildFilterChip("Mansions"),
        //     ],
        //   ),
        // ),
        SizedBox(height: 10.h),

        // 3. The List (Expanded to fix Unbounded Height)
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
            itemCount: units.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return SavedPropertyCard(
                property: units[index],
                onDelete: () {
                  context.read<FavoritesBloc>().add(
                    ToggleFavorite(
                      unitId: units[index].id ?? "",
                      userId: context
                          .read<SessionCubit>()
                          .currentUserId!, // لازم تجيب الـ userId الحقيقي من الـ Auth
                    ),
                  );
                },
                onTap: () {
                  context.pushNamed(
                    AppRoutes.detailsScreenName,
                    extra: units[index],
                  );
                  // Go to Details
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget مساعدة للـ Chips
  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      child: Chip(
        label: Text(label),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: isSelected
            ? const Color(0xFF0D0D4B)
            : Colors.grey.shade100,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      ),
    );
  }
}
