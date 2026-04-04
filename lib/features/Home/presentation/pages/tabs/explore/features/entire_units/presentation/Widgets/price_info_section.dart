import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/locale/locale_cubit.dart';
import 'package:lux_estate/core/extentions/unit_formatter.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class PriceInfoSection extends StatelessWidget {
  const PriceInfoSection({
    super.key,
    required this.isVisible,
    required this.propertyUnit,
  });

  final bool isVisible;
  final PropertyUnitEntity propertyUnit;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.end, // Aligns price and text to bottom
        children: [
          // LEFT SIDE: Name and Location
          BlocBuilder<LocaleCubit, Locale>(
          builder: (context, state) {final name = state == Locale.fromSubtags(languageCode: "ar") ? propertyUnit.arName : propertyUnit.enName;
            final locationName = state == Locale.fromSubtags(languageCode: "ar") ? propertyUnit.location?.arName : propertyUnit.location?.enName;
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Takes only space it needs
                  children: [
                    Text(
                      name ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.h,
                    ), // Consistent spacing instead of Spacer()
                    if (locationName != null)
                      Row(
                        // Horizontal layout for icon and text looks better in rows
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.primary,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                            locationName.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium,

                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),

          SizedBox(width: 10.w), // Gap between info and price
          // RIGHT SIDE: Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.investment_price.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                propertyUnit
                    .formattedPriceFull, // Using your price formatting extension
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ).p(AppSizes.paddingM.w),
    );
  }
}
