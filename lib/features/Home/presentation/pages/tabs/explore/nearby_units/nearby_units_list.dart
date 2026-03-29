import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/widgets/property_card.dart';

class NearbyUnitsListPage extends StatelessWidget {
  const NearbyUnitsListPage({super.key, required this.units});
  final List<PropertyUnitEntity> units;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Text(
                "Nearby Units",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemCount: units.length,
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio: 1.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: PropertyCard(
                        propertyUnit: units[index],
                        isDataVisable: true,
                        viewUnitDetails: () {
                          context.pushNamed(
                            AppRoutes.detailsScreenName,
                            extra: units[index],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
