import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/widgets/featured_property_card.dart';

class FeaturedPropertiesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppSizes.paddingL.w,
            top: AppSizes.paddingM.h,
            bottom: AppSizes.paddingS.h,
          ),
          child: Row(
            children: [
              Text(
                'Featured Properties',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        Cards(),
      ],
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        // Using a ratio is safer than a fixed height
        // 0.75 means height is approx 1.33x the width
        aspectRatio: 0.7,
        viewportFraction: 00.95, // Shows edges of side cards
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        enlargeCenterPage: true, // Makes the UI look more premium
        enlargeFactor: 0.2,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: 3,
      itemBuilder: (context, index, realIndex) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: const FeaturedPropertyCard(),
      ),
    );
  }
}
