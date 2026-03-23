import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/widgets/category_section.dart';
import 'package:lux_estate/features/Home/presentation/widgets/property_card.dart';

class RecommendedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySection(),

        Padding(
          padding: EdgeInsets.only(
            left: AppSizes.paddingL.w,
            top: AppSizes.paddingM.h,
            bottom: AppSizes.paddingS.h,
          ),
          child: Row(
            children: [
              Text(
                'Recommended for You',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        Cards(units: []),
      ],
    );
  }
}

class Cards extends StatelessWidget {
  Cards({super.key, required this.units});
  List<PropertyUnitEntity> units;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        // Using a ratio is safer than a fixed height
        // 0.75 means height is approx 1.33x the width
        aspectRatio: 0.85,
        viewportFraction: 00.95, // Shows edges of side cards
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        enlargeCenterPage: true, // Makes the UI look more premium
        enlargeFactor: 0.2,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: units.length > 3 ? units.length : 3,
      itemBuilder: (context, index, realIndex) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: const PropertyCard(),
      ),
    );
  }
}
