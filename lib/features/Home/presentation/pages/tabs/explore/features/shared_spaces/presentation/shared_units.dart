import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/shared_spaces/presentation/widgets/StudentFriendlySection.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/shared_spaces/presentation/widgets/buid_shared_recommendations.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/shared_spaces/presentation/widgets/build_filter_and_sort.dart';

class SharedHousingTab extends StatelessWidget {
  const SharedHousingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: Column(
              children: [
                BuildFilterAndSortUI(),
                BuildSharedRecommendations(),
                StudentFriendlySection(),
                BlocBuilder<NavbarVisibilityCubit, bool>(
                  builder: (context, state) {
                    return state ? 80.h.verticalSpace : 40.h.verticalSpace;
                  },
                ),
                // Expanded(child: _buildPropertyList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildPropertyList() {
  //   return ListView(
  //     padding: EdgeInsets.all(20.w),
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Curated Shared Spaces',
  //             style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
  //           ),
  //           Spacer(),
  //           Text(
  //             '24 results',
  //             style: TextStyle(
  //               fontSize: 14.sp,
  //               color: Colors.cyan,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           AppSizes.spaceS.horizontalSpace,
  //           Container(
  //             width: 40.w,
  //             decoration: BoxDecoration(
  //               color: AppColors.primary,
  //               borderRadius: BorderRadius.circular(12.r),
  //             ),
  //             child: IconButton(
  //               icon: Icon(Icons.tune, color: Colors.white),
  //               onPressed: () {},
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 20.h),
  //       _buildPropertyCard(
  //         title: 'Bed in Master Room, Dokki',
  //         location: '12 El-Nile St., Giza, EG',
  //         price: '3,500',
  //         gender: 'GENDER: MALE',
  //         availability: '1 BED AVAILABLE',
  //         imageUrl: AppAssetsPath.house,
  //         icons: [Icons.wifi, Icons.ac_unit, Icons.local_laundry_service],
  //       ),
  //       _buildPropertyCard(
  //         title: 'Shared Room, New Cairo',
  //         location: 'Fifth Settlement, Area 1, EG',
  //         price: '4,200',
  //         gender: 'GENDER: FEMALE',
  //         availability: '2 BEDS AVAILABLE',
  //         imageUrl: AppAssetsPath.loft,
  //         icons: [Icons.wifi, Icons.ac_unit, Icons.kitchen],
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildPropertyCard({
  //   required String title,
  //   required String location,
  //   required String price,
  //   required String gender,
  //   required String availability,
  //   required String imageUrl,
  //   required List<IconData> icons,
  // }) {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 25.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Stack(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(20.r),
  //               child: Image.asset(
  //                 imageUrl,
  //                 height: 220.h,
  //                 width: double.infinity,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             Positioned(
  //               top: 15.h,
  //               left: 15.w,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   _buildImageBadge(gender, Colors.white.withOpacity(0.9)),
  //                   SizedBox(height: 8.h),
  //                   _buildImageBadge(availability, const Color(0xFF9FF4CD)),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12.h),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
  //             ),
  //             RichText(
  //               text: TextSpan(
  //                 children: [
  //                   TextSpan(
  //                     text: '\$$price',
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 18.sp,
  //                     ),
  //                   ),
  //                   TextSpan(
  //                     text: '/mo',
  //                     style: TextStyle(color: Colors.grey, fontSize: 12.sp),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         Text(
  //           location,
  //           style: TextStyle(fontSize: 12.sp, color: Colors.grey),
  //         ),
  //         SizedBox(height: 10.h),
  //         Row(
  //           children: icons
  //               .map(
  //                 (icon) => Padding(
  //                   padding: EdgeInsets.only(right: 15.w),
  //                   child: Icon(icon, size: 20.sp, color: Colors.grey[700]),
  //                 ),
  //               )
  //               .toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildImageBadge(String text, Color color) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(8.r),
  //     ),
  //     child: Text(
  //       text,
  //       style: TextStyle(
  //         fontSize: 10.sp,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.black,
  //         letterSpacing: 0.5,
  //       ),
  //     ),
  //   );
  // }
}
