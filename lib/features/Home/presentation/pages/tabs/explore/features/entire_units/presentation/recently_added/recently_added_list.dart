import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/build_sectionHeader.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/property_card.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class RecentlyAddedListPage extends StatelessWidget {
  const RecentlyAddedListPage({super.key, required this.units});
  final List<PropertyUnitEntity> units;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your Title
            BuildSectionHeader(title: LocaleKeys.recently_added.tr()).m(),
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
                        isDataVisible: true,
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
