import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/locale/locale_cubit.dart';
import 'package:lux_estate/core/extentions/unit_formatter.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

class SharedCardImageStack extends StatelessWidget {
  final PropertyUnitEntity propertyUnit;
  final VoidCallback? onSaveToggle;

  const SharedCardImageStack({
    super.key,
    required this.propertyUnit,
    this.onSaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Background Image
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32.r),
            child: buildPropertyImage(propertyUnit.imageUrl),
          ),
        ),

        // 2. Dark Gradient Overlay (لتوضيح النصوص البيضاء)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),

        // 3. Top Right: Match Percentage Badge
        Positioned(top: 16.h, right: 16.w, child: _MatchBadge(percent: 92)),

        // 4. Bottom Section: Info & Price
        BlocBuilder<LocaleCubit, Locale>(
          builder: (context, state) {final name = state == Locale.fromSubtags(languageCode: "ar") ? propertyUnit.arName : propertyUnit.enName;
            final locationName = state == Locale.fromSubtags(languageCode: "ar") ? propertyUnit.location?.arName : propertyUnit.location?.enName;
            return Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title & Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          name ?? "The Helix Penthouse",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      _PriceWidget(price: propertyUnit.formattedPriceFull),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Location Row
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        locationName ?? "New Cairo, District 5",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Bottom Badges (Type & Rating)
                  Row(
                    children: [
                      _InfoChip(
                        label: propertyUnit.unitType ?? "Private Suite",
                      ),
                      SizedBox(width: 8.w),
                      _InfoChip(label: "4.8", icon: Icons.star),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// Badge نسبة التوافق
class _MatchBadge extends StatelessWidget {
  final int percent;
  const _MatchBadge({required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF6CF0A1), // اللون الأخضر في الصورة
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 14.sp, color: Colors.black87),
          SizedBox(width: 4.w),
          Text(
            "$percent% Match",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// السعر مع /mo
class _PriceWidget extends StatelessWidget {
  final String price;
  const _PriceWidget({required this.price});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: price,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          TextSpan(
            text: "/mo",
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}

// الـ Chips اللي تحت (Private Suite / Rating)
class _InfoChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  const _InfoChip({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Glassmorphism effect
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14.sp, color: Colors.white),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
