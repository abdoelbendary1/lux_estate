import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';

class HomeAppBar extends StatelessWidget {
  final UserEntity? user;

  const HomeAppBar({super.key, this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        left: AppSizes.paddingL.w,
        right: AppSizes.paddingXS.w,
        top: AppSizes.paddingXS.h,
        bottom: AppSizes.paddingXS.h,
      ),
      child: Column(
        children: [
          AppSizes.spaceS.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WELCOME BACK",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                  AppSizes.spaceXS.verticalSpace,

                  Text(
                    textAlign: TextAlign.start,
                    "Good Morning, ${user?.fullName ?? "Guest"}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                minRadius: 20.r,
                maxRadius: 30.r,
                backgroundImage: AssetImage(AppAssetsPath.user),
                backgroundColor: AppColors.backgroundWhite,
              ),
              AppSizes.spaceS.horizontalSpace,
              // Spacer(),
              // IconButton(
              //   onPressed: () {
              //     // Trigger logout through AuthBloc
              //     context.read<AuthBloc>().add(UserLogoutEvent());
              //     // GoRouter will automatically kick the user to Login
              //   },
              //   icon: Icon(Icons.logout, color: AppColors.primary),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
