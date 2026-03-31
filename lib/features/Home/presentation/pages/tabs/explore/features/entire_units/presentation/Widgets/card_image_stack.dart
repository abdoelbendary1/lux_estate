import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/build_badge_UI.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/build_save_UI.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/stats_row.dart';


class CardImageStack extends StatelessWidget {
  final PropertyUnitEntity propertyUnit;
  final VoidCallback? onSaveToggle;

  const CardImageStack({
    super.key,
    required this.propertyUnit,
    this.onSaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Image
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          child: buildPropertyImage(propertyUnit.imageUrl),
        ),
        // 2. Gradient Overlay
        const CardGradient(),
        // 3. Badges (Match & Save)
        if (propertyUnit.isMatched ?? false)
          Positioned(
            top: 12.h,
            left: 12.w,
            child: const BuildBadgeUi(badgeText: ""),
          ),
        Positioned(
          top: 12.h,
          right: 12.w,
          child: BuildSaveUI(
            isSaved: propertyUnit.isSaved,
            onSaveToggle: onSaveToggle,
          ),
        ),
        // 4. Stats Row (Area, Beds, Baths)
        PropertyStatsRow(unit: propertyUnit),
      ],
    );
  }
}

class CardGradient extends StatelessWidget {
  const CardGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.transparent, AppColors.black.withOpacity(0.8)],
          stops: const [0.6, 1.0],
        ),
      ),
    );
  }
}
