import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:lux_estate/core/helpers/helpers.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/app_button.dart';
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
                  _buildTopActionbar(context),
                  AppSizes.spaceL.verticalSpace,

                  // 2. Main Image and Listing Title
                  _buildImageSection(),
                  AppSizes.spaceL.verticalSpace,

                  // 3. Location Text (Matches image position)
                  _buildLocationRow(unit.location?.name ?? ""),
                  AppSizes.spaceM.verticalSpace,

                  // 4. Property Stats Row (Sq Ft, Beds, Baths)
                  _buildStatsRow(unit),
                  AppSizes.spaceL.verticalSpace,

                  // 5. Section: Architectural Narrative
                  _buildSectionTitle('Architectural Narrative'),
                  AppSizes.spaceS.verticalSpace,
                  _buildBodyText(
                    'Designed by world-renowned Studio Forma, The Azure Pavilion represents a pinnacle of contemporary Mediterranean architecture. The property features seamless indoor-outdoor transitions, floor-to-ceiling glass systems, and a curated selection of rare Italian marbles and sustainable cedar.',
                  ),
                  AppSizes.spaceL.verticalSpace,

                  // 6. Developer Card
                  GestureDetector(
                    onTap: () => showAgentModal(context),
                    child: _buildDeveloperCard(
                      unit.developer ?? DeveloperEntity(),
                    ),
                  ),
                  AppSizes.spaceL.verticalSpace,

                  // 7. Price and Contact Options
                  _buildPriceSection(
                    price: formattedPrice,
                    onTap: () => showAgentModal(context),
                  ),
                  AppSizes.spaceL.verticalSpace,

                  // 8. Location & Neighborhood
                  _buildSectionTitle('Location & Neighborhood'),
                  AppSizes.spaceL.verticalSpace,
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

  ClipRRect _buildImageSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // Replace with your actual asset or NetworkImage
          AspectRatio(
            aspectRatio: 1.2,
            child: buildPropertyImage(unit.imageUrl),
          ),
          // exclusive listing tag and title overlay
          _buildListingHeader(unit),
        ],
      ),
    );
  }

  Row _buildTopActionbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconButton(Icons.arrow_back, onTap: () => context.pop()),
        Row(
          children: [
            _buildIconButton(Icons.favorite_border),
            SizedBox(width: 10.w),
            _buildIconButton(Icons.share),
          ],
        ),
      ],
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

  Widget _buildListingHeader(PropertyUnitEntity unit) {
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
              color: getListColor(
                unit.unitCategory?.id ?? "1",
              ).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              unit.unitCategory?.name ?? "",
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.greenTagText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            unit.name ?? "",
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
          size: 20.r,
        ),
        SizedBox(width: 6.w),
        Text(
          location,
          style: TextStyle(fontSize: 18.sp, color: AppColors.accentBlue),
        ),
      ],
    );
  }

  Widget _buildStatsRow(PropertyUnitEntity unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
          title: "METERS",
          value: convertFromSqFtToSqMeters(
            unit.size?.toDouble() ?? 0.0,
          ).toString(),
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
        child: AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            width: 100.w,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.cardGrey,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  flex: 2,
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
                style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
              ),
              Text(
                developer.name ?? 'Julian Vane Enterprises',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection({String? price, VoidCallback? onTap}) {
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
          BuildAppButton(
            leadingIcon: Icons.email_outlined,
            actionText: 'Contact Agent',
            onTap: onTap,
            backgroundColor: AppColors.accentBlue,
          ),
          // SizedBox(height: 12.h),
          // BuildAppButton(
          //   leadingIcon: Icons.phone,
          //   actionText: 'Call Now',
          //   curvedTop: false,
          //   onTap: () {},
          //   backgroundColor: AppColors.accentBlue,
          // ),
          // SizedBox(height: 15.h),
          // Align(
          //   alignment: AlignmentGeometry.center,
          //   child: Text(
          //     'Schedule Private Tour',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: 13.sp,
          //       color: AppColors.accentBlue,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
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
                  // Change this to your unique package name from your build.gradle
                  userAgentPackageName: 'com.luxestate.app.mobile',
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

  void showAgentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Required for custom shape/color
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          decoration: BoxDecoration(
            // Using a deep navy gradient to match the image
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF000046), Color(0xFF000020)],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 30.h),

              // Profile Image with Online Indicator
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.white12,
                    child: CircleAvatar(
                      radius: 48.r,
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1560250097-0b93528c311a?&fm=jpg&ixid=MnwxMTkyMXwwfDF8c2VhcmNofDh8fG1hbiUyMGluJTIwc3VpdHxlbnwwfHx8fDE2NzU4NDM5NDM&q=80&w=400',
                      ), // Replace with your image
                    ),
                  ),
                  Positioned(
                    bottom: 5.r,
                    right: 5.r,
                    child: Container(
                      height: 18.r,
                      width: 18.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ADE80), // Online green
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF000046),
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Name and Title
              Text(
                "Julian Sterling",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "PRINCIPAL DEVELOPER",
                style: TextStyle(
                  color: const Color(0xFFC5A358), // Golden accent
                  fontSize: 12.sp,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),

              // Quote
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '"Crafting modern legacies through architectural excellence."',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Action Icons (Message, Audio, Video)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionIcon(Icons.chat_bubble_outline, "MESSAGE"),
                  _buildActionIcon(Icons.phone_outlined, "AUDIO"),
                  _buildActionIcon(Icons.videocam_outlined, "VIDEO"),
                ],
              ),
              SizedBox(height: 32.h),

              // Primary Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFC5A358,
                    ), // Golden/Tan color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    "SCHEDULE PRIVATE VIEWING",
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Response Time Text
              Text(
                "AVERAGE RESPONSE TIME: UNDER 5 MINS",
                style: TextStyle(
                  color: Colors.white30,
                  fontSize: 10.sp,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: const BoxDecoration(
            color: Colors.white10,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFC5A358), size: 24.r),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 10.sp),
        ),
      ],
    );
  }
}
