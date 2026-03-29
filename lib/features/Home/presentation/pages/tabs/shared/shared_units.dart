import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';

class SharedHousingTab extends StatelessWidget {
  const SharedHousingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FE),

        body: Column(
          children: [
            _buildSearchAndFilters(),
            Expanded(child: _buildPropertyList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEDEEF7),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search location or property type...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15.h),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          child: Row(
            children: [
              _buildFilterChip('Accommodation Type', isDark: true),
              SizedBox(width: 10.w),
              _buildFilterChip('Gender Policy'),
              SizedBox(width: 10.w),
              _buildFilterChip('Price Range'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, {bool isDark = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : const Color(0xFFEDEEF7),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.keyboard_arrow_down,
            color: isDark ? Colors.white : Colors.black,
            size: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyList() {
    return ListView(
      padding: EdgeInsets.all(20.w),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Curated Shared Spaces',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '24 results',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.cyan,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        _buildPropertyCard(
          title: 'Bed in Master Room, Dokki',
          location: '12 El-Nile St., Giza, EG',
          price: '3,500',
          gender: 'GENDER: MALE',
          availability: '1 BED AVAILABLE',
          imageUrl: AppAssetsPath.house,
          icons: [Icons.wifi, Icons.ac_unit, Icons.local_laundry_service],
        ),
        _buildPropertyCard(
          title: 'Shared Room, New Cairo',
          location: 'Fifth Settlement, Area 1, EG',
          price: '4,200',
          gender: 'GENDER: FEMALE',
          availability: '2 BEDS AVAILABLE',
          imageUrl: AppAssetsPath.loft,
          icons: [Icons.wifi, Icons.ac_unit, Icons.kitchen],
        ),
      ],
    );
  }

  Widget _buildPropertyCard({
    required String title,
    required String location,
    required String price,
    required String gender,
    required String availability,
    required String imageUrl,
    required List<IconData> icons,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  imageUrl,
                  height: 220.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 15.h,
                left: 15.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageBadge(gender, Colors.white.withOpacity(0.9)),
                    SizedBox(height: 8.h),
                    _buildImageBadge(availability, const Color(0xFF9FF4CD)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$$price',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    TextSpan(
                      text: '/mo',
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            location,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 10.h),
          Row(
            children: icons
                .map(
                  (icon) => Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Icon(icon, size: 20.sp, color: Colors.grey[700]),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
