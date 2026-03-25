import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/build_unit_image.dart';
import 'package:lux_estate/features/Home/domain/entities/developer_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

// --- Theme and Const Colors (Matches Image) ---

// --- Main Screen ---
class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({super.key, required this.unit});
  final PropertyUnitEntity unit;

  @override
  Widget build(BuildContext context) {
    String formattedPrice = NumberFormat('#,###').format(unit.price ?? 0);
    // Standard real estate screen layout
    return Scaffold(
      backgroundColor: AppColors.darkBlueBg,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Top Action Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconButton(
                        Icons.arrow_back,
                        onTap: () => context.pop(),
                      ),
                      Row(
                        children: [
                          _buildIconButton(Icons.favorite_border),
                          SizedBox(width: 10.w),
                          _buildIconButton(Icons.share),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // 2. Main Image and Listing Title
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        // Replace with your actual asset or NetworkImage
                        SizedBox(
                          height: 200.h,
                          child: buildPropertyImage(unit.imageUrl),
                        ),
                        // exclusive listing tag and title overlay
                        _buildListingHeader(
                          unit.name ?? "",
                          'EXCLUSIVE LISTING',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // 3. Location Text (Matches image position)
                  _buildLocationRow(unit.location?.name ?? ""),
                  SizedBox(height: 20.h),

                  // 4. Property Stats Row (Sq Ft, Beds, Baths)
                  _buildStatsRow(unit),
                  SizedBox(height: 30.h),

                  // 5. Section: Architectural Narrative
                  _buildSectionTitle('Architectural Narrative'),
                  SizedBox(height: 12.h),
                  _buildBodyText(
                    'Designed by world-renowned Studio Forma, The Azure Pavilion represents a pinnacle of contemporary Mediterranean architecture. The property features seamless indoor-outdoor transitions, floor-to-ceiling glass systems, and a curated selection of rare Italian marbles and sustainable cedar.',
                  ),
                  SizedBox(height: 25.h),

                  // 6. Developer Card
                  _buildDeveloperCard(unit.developer ?? DeveloperEntity()),
                  SizedBox(height: 25.h),

                  // 7. Price and Contact Options
                  _buildPriceSection(formattedPrice),
                  SizedBox(height: 25.h),

                  // 8. Location & Neighborhood
                  _buildSectionTitle('Location & Neighborhood'),
                  SizedBox(height: 12.h),
                  _buildMapWidget(),
                  // Add extra padding at the bottom so content isn't covered by bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDER HELPERS ---

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: AppColors.cardGrey,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.textWhite, size: 20.r),
      ),
    );
  }

  Widget _buildListingHeader(String name, listName) {
    return Container(
      padding: EdgeInsets.all(16.r),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.greenTagBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              listName,
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.greenTagText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.sp,
              color: AppColors.textWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(String location) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.accentBlue,
          size: 16.r,
        ),
        SizedBox(width: 6.w),
        Text(
          location,
          style: TextStyle(fontSize: 13.sp, color: AppColors.accentBlue),
        ),
      ],
    );
  }

  Widget _buildStatsRow(PropertyUnitEntity unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
          title: 'SQ. FT.',
          value: unit.size?.toDouble().toString() ?? "N/A",
        ),
        Spacer(),
        _buildStatCard(
          title: 'BEDROOMS',
          value: unit.bedCount?.toInt().toString() ?? "N/A",
        ),
        Spacer(),

        _buildStatCard(
          title: 'BATHROOMS',
          value: unit.bathCount?.toInt().toString() ?? "N/A",
        ),
      ],
    );
  }

  Widget _buildStatCard({required String title, required String value}) =>
      Expanded(
        flex: 5,
        child: Container(
          width: 100.w,
          height: 110.h,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.cardGrey,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        color: AppColors.textWhite,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildBodyText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        color: Colors.white70,
        height: 1.5, // Improves readability
      ),
    );
  }

  Widget _buildDeveloperCard(DeveloperEntity developer) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardGrey, // Deep Blue
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(color: AppColors.buttonLightBlue, width: 2.w),
          right: .none,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundImage: NetworkImage(
              developer.imageUrl ??
                  'https://images.unsplash.com/photo-1560250097-0b93528c311a?&fm=jpg&ixid=MnwxMTkyMXwwfDF8c2VhcmNofDh8fG1hbiUyMGluJTIwc3VpdHxlbnwwfHx8fDE2NzU4NDM5NDM&q=80&w=400',
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                developer.jobTitles ?? 'LEAD DEVELOPER',
                style: TextStyle(fontSize: 10.sp, color: AppColors.textGrey),
              ),
              Text(
                developer.name ?? 'Julian Vane Enterprises',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.accentBlue,
              size: 28.r,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(String? price) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingXL.w,
        vertical: AppSizes.paddingXL.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ASKING PRICE',
            style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
          ),
          SizedBox(height: 6.h),
          Text(
            '\$${price ?? 'N/A'}',
            style: TextStyle(
              fontSize: 32.sp,
              color: AppColors.textWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          _buildActionButton(
            Icons.email_outlined,
            'Message Agent',
            onTap: () {},
          ),
          SizedBox(height: 12.h),
          _buildActionButton(
            Icons.phone,
            'Call Now',
            isFilled: true,
            onTap: () {},
          ),
          SizedBox(height: 15.h),
          Align(
            alignment: AlignmentGeometry.center,
            child: Text(
              'Schedule Private Tour',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.accentBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label, {
    bool isFilled = false,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isFilled
              ? AppColors.buttonLightBlue
              : Colors.transparent,
          side: isFilled
              ? BorderSide.none
              : BorderSide(color: Colors.white24, width: 0.5.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.r,
              color: isFilled ? AppColors.darkBlueBg : AppColors.textWhite,
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isFilled ? AppColors.darkBlueBg : AppColors.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapWidget() {
    return Container(
      height: 280.h,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Stack(
          children: [
            // Using flutter_map from dependencies
            FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(34.0522, -118.2437), // Los Angeles
                initialZoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(34.0522, -118.2437),
                      width: 40.r,
                      height: 40.r,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.withOpacity(0.5),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: AppColors.darkBlueBg,
                          size: 24.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Floating control and details from the image
            Positioned(
              bottom: 12.h,
              left: 12.w,
              child: _buildAccessibilityWidget(),
            ),
            Positioned(bottom: 12.h, right: 12.w, child: _buildMapControls()),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilityWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              color: AppColors.accentBlue,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Icon(
              Icons.car_crash_sharp,
              color: AppColors.textWhite,
              size: 16.r,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prime Accessibility',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '12 mins to Sunset Boulevard',
                style: TextStyle(fontSize: 10.sp, color: AppColors.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapControls() {
    return Column(
      children: [
        _buildMapButton(Icons.add),
        SizedBox(height: 10.h),
        _buildMapButton(Icons.remove),
      ],
    );
  }

  Widget _buildMapButton(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(icon, color: AppColors.textWhite, size: 18.r),
    );
  }

  Widget _buildStaticBottomNav(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(color: Colors.white24, width: 0.5.r),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.message, size: 20.r, color: AppColors.textWhite),
                  SizedBox(width: 8.w),
                  Text(
                    'Message',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.only(right: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.buttonLightBlue,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.phone, size: 20.r, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
