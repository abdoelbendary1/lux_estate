import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/extentions/unit_formatter.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

class NearbyCard extends StatelessWidget {
  final PropertyUnitEntity unit;
  const NearbyCard({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutes.detailsScreenName, extra: unit),
      child: AspectRatio(
        aspectRatio: 0.9,
        child: Container(
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImage(), _buildContent(context)],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: AppColors.backgroundWhite, // Colors.white,
    borderRadius: BorderRadius.circular(20.r),
    boxShadow: [
      BoxShadow(
        color: AppColors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
    border: BorderDirectional(
      bottom: BorderSide(color: AppColors.secondary, width: 10.w),
    ),
  );

  Widget _buildImage() => ClipRRect(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    child: SizedBox(
      height: 160.h,
      width: double.infinity,
      child: buildPropertyImage(unit.imageUrl),
    ),
  );

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingS.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              unit.name(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    unit.locationName(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  unit.formattedPriceFull(
                    context,
                  ), // استخدام الـ Extension بتاعك
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.accentBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
