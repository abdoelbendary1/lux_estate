import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/locale/locale_cubit.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/extentions/unit_formatter.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart'; // الـ Extensions بتاعتك
import 'package:lux_estate/core/helpers/helpers.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

class RecentPropertyTile extends StatelessWidget {
  final PropertyUnitEntity unit;
  const RecentPropertyTile({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    // 1. استخدام الـ Theme لتقليل التكرار
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, state) {
        final name = state == Locale.fromSubtags(languageCode: "ar") ? unit.arName : unit.enName;
            final locationName = state == Locale.fromSubtags(languageCode: "ar") ? unit.location?.arName : unit.location?.enName;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Image Section ---
            _buildImage(),

            16.horizontalSpace, // استخدام Spacer Extension
            // --- Details Section ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryAndPrice(
                    context,
                    unit.formattedPriceCompact,
                    textTheme,
                  ),
                  8.verticalSpace,
                  _buildPropertyName(textTheme, name??""),
                  4.verticalSpace,
                  _buildLocation(textTheme, locationName??""),
                ],
              ),
            ),
          ],
        );
      },
    ).mOnly(b: 20.h); // استخدام Margin Extension بتاعك
  }

  // ميثود منفصلة للصورة لتقليل الزحمة في الـ build
  Widget _buildImage() {
    return SizedBox(
      width: 120.w,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: buildPropertyImage(unit.imageUrl),
        ),
      ),
    );
  }

  Widget _buildCategoryAndPrice(
    BuildContext context,
    String price,
    TextTheme textTheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Category Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: getListColor(unit.categoryId ?? "1").withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            PropertyCategories.values
                    .firstWhere((element) => element.id == unit.categoryId)
                    .getLocalizedName(context) ??
                "Apartment",
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Price
        Expanded(
          child: Text(
            price,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ).pOnly(e: AppSizes.paddingM),
        ),
      ],
    );
  }

  Widget _buildPropertyName(TextTheme textTheme ,String name) {
    return Text(
      name ,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildLocation(TextTheme textTheme, String location) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 14.sp, color: AppColors.grey),
        4.horizontalSpace,
        Expanded(
          child: Text(
            location  ,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(color: AppColors.grey),
          ),
        ),
      ],
    );
  }
}
