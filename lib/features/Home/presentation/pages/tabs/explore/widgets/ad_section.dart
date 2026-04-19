import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class LuxCarouselCard extends StatefulWidget {
  const LuxCarouselCard({super.key});

  @override
  State<LuxCarouselCard> createState() => _LuxCarouselCardState();
}

class _LuxCarouselCardState extends State<LuxCarouselCard> {
  int _currentIndex = 0;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1000',
    'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?q=80&w=1000',
    'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?q=80&w=1000',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 120.0,
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          items: imgList.map((url) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  ),
                ),
                padding: const EdgeInsets.all(12),
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "Exclusive Penthouse Offer",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12.h),
        // Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentIndex == entry.key ? 18.0 : 7.0,
              height: 7.0,
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _currentIndex == entry.key
                    ? AppColors
                          .primary // Deep Navy
                    : AppColors.grey.withOpacity(0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
