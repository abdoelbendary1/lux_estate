import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/locale/locale_cubit.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/utils/app_button.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/card_image_stack.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/price_info_section.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.propertyUnit,
    this.viewUnitDetails,
    this.onSaveToggle,
    this.isDataVisible = false,
  });
  final PropertyUnitEntity propertyUnit;
  final VoidCallback? viewUnitDetails;
  final bool isDataVisible;
  final VoidCallback? onSaveToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: viewUnitDetails,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: CardImageStack(
                propertyUnit: propertyUnit,
                onSaveToggle: onSaveToggle,
              ),
            ),

            // Visibility(
            //   visible: !isDataVisible,
            //   child: Expanded(
            //     flex: 1,
            //     child: BuildAppButton(
            //       curvedTop: false,
            //       onTap: viewUnitDetails,
            //       actionText: LocaleKeys.explore_details.tr(),
            //       trailingIcon: Icons.arrow_forward,
            //     ),
            //   ),
            // ),
            PriceInfoSection(
              isVisible: isDataVisible,
              propertyUnit: propertyUnit,
            ),
          ],
        ),
      ),
    );
  }
}
