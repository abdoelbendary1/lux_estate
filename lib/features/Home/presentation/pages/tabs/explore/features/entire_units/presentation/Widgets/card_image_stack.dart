import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

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
        // 1. الصورة الأساسية (مرة واحدة فقط)
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              AppSizes.radiusL,
            ), // استخدام الـ Theme sizes
            child: buildPropertyImage(propertyUnit.imageUrl),
          ),
        ),

        // 2. الجريدينت (فصلناه في ودجت منفصلة بـ const)
        const CardGradientOverlay(),

        // 3. بادج التطابق (المفروض النسبة تيجي من الداتا)
        Positioned(top: 16.h, right: 16.w, child: _MatchBadge(percent: 92)),

        // 4. محتوى الكارت
        Positioned(
          bottom: 20.h,
          left: 20.w,
          right: 20.w,
          child: _CardContent(propertyUnit: propertyUnit),
        ),
      ],
    );
  }
}

// فصل محتوى الكلام في ودجت داخلية عشان الكود ميبقاش "شجرة" طويلة
class _CardContent extends StatelessWidget {
  final PropertyUnitEntity propertyUnit;
  const _CardContent({required this.propertyUnit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          propertyUnit.name ?? "The Helix Penthouse",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        AppSizes.spaceS.verticalSpace,
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: Colors.white, size: 18.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                propertyUnit.location?.name ?? "New Cairo, District 5",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        AppSizes.spaceL.verticalSpace,
        Row(
          children: [
            _InfoChip(
              label: "${propertyUnit.bedCount} ${LocaleKeys.bedrooms.tr()}",
              icon: Icons.bed_outlined,
            ),
            SizedBox(width: 8.w),
            _InfoChip(
              label: "${propertyUnit.bathCount} ${LocaleKeys.bathrooms.tr()}",
              icon: Icons.bathtub_outlined,
            ),
            const Spacer(),
            _ExploreDetailsBtn(),
          ],
        ),
      ],
    );
  }
}

// ودجت الجريدينت - تم تحسينها وتعميمها
class CardGradientOverlay extends StatelessWidget {
  const CardGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
            stops: const [0.4, 1.0],
          ),
        ),
      ),
    );
  }
}

// تم دمج _InfoChip و _InfoSharedChip في ودجت واحدة مرنة
class _InfoChip extends StatelessWidget {
  final String label;
  final IconData? icon;

  const _InfoChip({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14.sp, color: Colors.white),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreDetailsBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          LocaleKeys.explore_details.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        SizedBox(width: 4.w),
        Icon(Icons.arrow_forward, size: 18.sp, color: Colors.white),
      ],
    );
  }
}

class _MatchBadge extends StatelessWidget {
  final int percent;
  const _MatchBadge({required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF6CF0A1), // يفضل نقلها للـ AppColors.successGreen
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 12.sp, color: Colors.black),
          SizedBox(width: 4.w),
          Text(
            "$percent% Match",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
